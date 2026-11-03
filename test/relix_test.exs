defmodule RelixTest do
  use ExUnit.Case
  doctest Relix

  alias Relix.RPC

  test "test RPC success" do
    rpc = %Relix.RPC{
      node: :self,
      module: Relix.RPC,
      function: :new,
      args: []
    }

    assert {:ok, %Relix.RPC{node: nil}} ==
             rpc
             |> RPC.execute()
             |> RPC.response()
  end

  test "test no reachable nodes" do
    rpc = %Relix.RPC{
      node: "somenode"
    }

    assert %{rpc | status: :not_reachable} ==
             rpc
             |> RPC.execute()

    assert {:error, :not_executed} ==
             rpc
             |> RPC.execute()
             |> RPC.response()
  end

  test "test no reachable nodes error" do
    rpc = %Relix.RPC{
      node: :not_reachable_at_all,
      module: Relix.RPC,
      function: :new,
      args: []
    }

    expected_error =
      try do
        rpc |> Relix.RPC.execute!()
      rescue
        r -> r
      end

    assert expected_error.message
           |> String.contains?("No reachable nodes matching node: \"not_reachable_at_all\"")
  end

  test "test response select" do
    rpc = %Relix.RPC{
      node: :self
    }

    assert {:ok, %{"1" => :val}} ==
             rpc
             |> RPC.set_module(Map)
             |> RPC.set_function(:from_keys)
             |> RPC.set_arguments([[1, 2], :val])
             |> RPC.execute()
             |> RPC.response(select: [1])
  end

  # :erpc.call/5 re-raises a remote exit(Reason) as exit({:exception, Reason}).
  # Node shutdown uses :terminating. rescue does not catch that exit.
  test "maps a terminating node exit to not_reachable" do
    result = exit_rpc(:terminating) |> RPC.execute()

    assert result.status == :not_reachable
    assert {:error, :not_executed} == RPC.response(result)
  end

  test "maps other node-shutdown exits to not_reachable" do
    for reason <- [:shutdown, {:shutdown, :app_stop}, :killed] do
      assert %{status: :not_reachable} = exit_rpc(reason) |> RPC.execute()
    end
  end

  test "execute! raises RPCError when the remote node terminates" do
    assert_raise Relix.RPCError, ~r/No reachable nodes/, fn ->
      exit_rpc(:terminating) |> RPC.execute!()
    end
  end

  test "remote application exits still propagate" do
    assert catch_exit(exit_rpc(:boom) |> RPC.execute()) == {:exception, :boom}
  end

  test "remote exceptions still propagate" do
    rpc = %RPC{
      node: :self,
      module: __MODULE__,
      function: :raise_error,
      args: ["nope"]
    }

    assert_raise ErlangError, fn ->
      RPC.execute(rpc)
    end
  end

  test "remote throws still propagate" do
    rpc = %RPC{
      node: :self,
      module: __MODULE__,
      function: :throw_with,
      args: [:nope]
    }

    assert catch_throw(RPC.execute(rpc)) == :nope
  end

  def exit_with(reason), do: exit(reason)
  def raise_error(message), do: raise(message)
  def throw_with(value), do: throw(value)

  defp exit_rpc(reason) do
    %RPC{
      node: :self,
      module: __MODULE__,
      function: :exit_with,
      args: [reason]
    }
  end
end
