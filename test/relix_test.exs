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
end
