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

    assert %{ rpc | status: :no_reachable} ==
      rpc
      |> RPC.execute()

    assert {:error, :no_executed} ==
      rpc
      |> RPC.execute()
      |> RPC.response()
  end

  test "test response select" do
    rpc = %Relix.RPC{
      node: :self
    }

    assert {:ok ,  %{"1" => :val}} ==
      rpc
      |> RPC.set_module(Map)
      |> RPC.set_function(:from_keys)
      |> RPC.set_arguments([[1, 2], :val])
      |> RPC.execute()
      |> RPC.response(select: [1])

  end
end
