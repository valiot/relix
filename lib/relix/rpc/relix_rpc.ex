defmodule Relix.RPC do
  @moduledoc """
  This module contains a typed struct definition for
  holding RPC request related data and some functions
  for performing the request and handling its response as well.

  Most of the functions are pluggable, recieving an RPC struct
  as first argment and returning a modified RPC struct.

  The RPC execution response is hold in the RPC struct,
  while `RPC.response()` can retrieve such response
  """
  defstruct node: nil,
            module: nil,
            function: nil,
            args: [],
            response: nil,
            resp_body: nil,
            status: nil,
            attempts: 0

  @type t :: %__MODULE__{
          node: bitstring(),
          module: any(),
          function: atom(),
          args: list(any()),
          response: any(),
          resp_body: any(),
          status: :no_reachable | :executed,
          attempts: integer()
        }

  require Logger

  def new(), do: %__MODULE__{}

  @doc """
  This will perform the actuall rpc call.
  An arbitrary particular node `match_node` is chosen from a list of
  reachable nodes satsfyig the name criteria stablished in `RPC.node`
  """

  def execute!(%__MODULE__{} = rpc) do
    case execute(rpc) do
      %{status: :no_reachable} ->
        raise "No reachable nodes matching node: \"#{rpc.node}\"" |> add_source_node()

      executed ->
        executed
    end
  end

  def execute(%__MODULE__{} = rpc) do
    with {:reachable_nodes, [match_node | _more_nodes]} <-
           {:reachable_nodes, reachable_nodes(rpc)},
         response <-
           (try do
              :erpc.call(
                match_node,
                rpc.module,
                rpc.function,
                rpc.args
              )
            rescue
              e ->
                Logger.error("attempting: #{match_node}")
                reraise e, __STACKTRACE__
            end) do
      %{rpc | resp_body: response}
      |> put_status(:executed)
    else
      {:reachable_nodes, []} ->
        Logger.debug("⛓ no reachable cluster nodes")
        rpc |> put_status(:no_reachable)

      error ->
        {:error, error}
    end
  end

  def put_status(%__MODULE__{} = rpc, status) do
    %{rpc | status: status}
  end

  @doc """
  This will obtain a list of candidate nodes to execute the RPC call against.
  As RPC.node can contain a non exact node name.
  This function is executed just before performing an RPC execution to
  consider the current reachable nodes containing the `RPC.node` wildcard name.
  """
  def reachable_nodes(%__MODULE__{node: :self}) do
    [Node.self()]
  end

  def reachable_nodes(%__MODULE__{} = rpc) do
    Enum.filter(Node.list(), &String.contains?(to_string(&1), rpc.node))
    |> Enum.shuffle()
  end

  @doc """
  Gets the response from the RPC struct if already executed,
  or `{:error, :no_executed}` otherwise.
  If the remote function reponds with `{:error, _}`, `RPC.response` with return
  such error.
  Any other result besides `{:error, _} = result` will be
  wraped in `{:ok, result}`

  Selecting fields with `select:` option, a list of keys to be returned in the
  response if response is a map. `in:` can provide a function to return
  the map in a more complex response, where selected fields are expected to be.
  """
  @spec response(__MODULE__.t()) :: {:ok, any()} | {:error, any()}
  def response(%__MODULE__{status: :executed, resp_body: {:error, _} = resp_error}) do
    resp_error
  end

  def response(%__MODULE__{status: :executed} = rpc) do
    {:ok, rpc.resp_body}
  end

  def response(%__MODULE__{status: :executed, resp_body: {:error, _} = resp_error}) do
    resp_error
  end

  def response(%__MODULE__{}) do
    {:error, :no_executed}
  end

  def response(%__MODULE__{status: :executed, resp_body: {:error, _} = resp_error}, _) do
    resp_error
  end

  def response(%__MODULE__{status: :executed} = rpc, select: response_keys) do
    {:ok,
     Enum.reduce(
       response_keys,
       %{},
       fn k, acc -> Map.put(acc, to_string(k), get_in(rpc.resp_body, [Access.key!(k)])) end
     )}
  end

  def response(%__MODULE__{status: :executed} = rpc, select: response_keys, in: f) do
    {:ok,
     Enum.reduce(
       response_keys,
       %{},
       fn k, acc -> Map.put(acc, to_string(k), get_in(f.(rpc.resp_body), [Access.key!(k)])) end
     )}
  end

  def response(%__MODULE__{}, _opts) do
    {:error, :no_executed}
  end

  def set_arguments(%__MODULE__{} = rpc, arguments) do
    %{rpc | args: arguments}
  end

  def set_module(%__MODULE__{} = rpc, module) do
    %{rpc | module: module}
  end

  def set_function(%__MODULE__{} = rpc, function) do
    %{rpc | function: function}
  end

  defp add_source_node(msg) do
    to_string(Node.self()) <> " : " <> msg
  end
end
