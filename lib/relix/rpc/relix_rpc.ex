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
            fallback_fun: nil,
            fallback_arg: nil,
            resp_body: nil,
            status: nil,
            attempts: 0

  @type t :: %__MODULE__{
          node: bitstring(),
          module: any(),
          function: atom(),
          args: list(any()),
          response: any(),
          fallback_fun: function(),
          fallback_arg: any(),
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
  def execute(%__MODULE__{} = rpc) do
    with {:reachable_nodes, [match_node | _more_nodes]} <-
           {:reachable_nodes, reachable_nodes(rpc)},
         response <-
           :erpc.call(
             match_node,
             rpc.module,
             rpc.function,
             rpc.args
           ) do
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
  defp reachable_nodes(%__MODULE__{} = rpc) do
    Enum.filter(Node.list(), &String.contains?(to_string(&1), rpc.node))
  end

  @doc """
  Gets the response from the RPC struct if already executed,
  or `{:error, :no_executed}` otherwise.
  """
  def response(%__MODULE__{status: :executed} = rpc) do
    {:ok, rpc.resp_body}
  end

  def response(%__MODULE__{}) do
    {:error, :no_executed}
  end

  def response(%__MODULE__{status: :executed} = rpc, select: response_keys) do
    {:ok,
     Enum.reduce(
       response_keys,
       %{},
       fn k, acc -> Map.put(acc, to_string(k), get_in(rpc.resp_body, [Access.key!(k)])) end
     )}
  end

  def set_arguments(%__MODULE__{} = rpc, arguments) do
    %{rpc | args: arguments}
  end

  def set_module(%__MODULE__{} = rpc, module) do
    %{rpc | module: module}
  end

  def set_fallback(rpc = %__MODULE__{}, function: function, arg: arg) do
    %{rpc | fallback_fun: function, fallback_arg: arg}
  end
end
