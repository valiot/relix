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
end
