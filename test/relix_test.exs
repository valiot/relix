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

  # Reproduces OPS-4536: erpc.call surfaces exit(R) from the remote MFA as {:exception, R}
  # (a catchable :exit, not a rescue-able exception). Before the fix this crashed the caller.
  # Plain `exit(:terminating)` in the MFA yields exactly `{:exception, :terminating}` at the call site.
  def cause_erpc_terminating_exit, do: exit(:terminating)

  test "handles {:exception, :terminating} exit from erpc.call and returns error response" do
    rpc = %Relix.RPC{
      node: :self,
      module: __MODULE__,
      function: :cause_erpc_terminating_exit,
      args: []
    }

    executed = RPC.execute(rpc)
    assert executed.status == :executed
    assert {:error, {:rpc_exit, {:exception, :terminating}}} = RPC.response(executed)
  end

  def cause_erpc_throw, do: throw(:boom)

  test "handles throw from erpc.call and returns error response" do
    rpc = %Relix.RPC{
      node: :self,
      module: __MODULE__,
      function: :cause_erpc_throw,
      args: []
    }

    executed = RPC.execute(rpc)
    assert executed.status == :executed
    assert {:error, {:rpc_exit, {:throw, :boom}}} = RPC.response(executed)
  end
end
