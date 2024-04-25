
![Relix Logo](https://github.com/valiot/relix/blob/a19b7019305a8e560d4fb19f235b819aaa912a9b/priv/static/images/relix.png)

# Relix

** Remote Execution Library for Elixir **

Relix provides rpc interfacing with `Relix.RPC`.

The `Relix.RPC` module provides a struct for holding rpc call data 

```elixir
iex(relix@127.0.0.1)1> Relix.RPC.new
%Relix.RPC{
  node: nil,
  module: nil,
  function: nil,
  args: [],
  response: nil,
  resp_body: nil,
  status: nil,
  attempts: 0
}
```

The `:node` field is quite handy and can be set for a string, which is expected to be contained in the
target RPC node name, or `:self` for performing RPC calls to itself.

```elixir
iex(relix@127.0.0.1)2> rpc = %Relix.RPC{
  node: :self,
  module: Relix.RPC,
  function: :new,
  args: []
}

iex(relix@127.0.0.1)3> rpc |> RPC.execute() |> RPC.response()
{:ok,
 %Relix.RPC{
   node: nil,
   module: nil,
   function: nil,
   args: [],
   response: nil,
   resp_body: nil,
   status: nil,
   attempts: 0
 }}
```

`RPC.execute()` will perform an RPC call with provided parameters. If the RPC call succeeded, it will set `RPC.status: :executed`, and the response will be set under `RPC.resp_body` and can be extracted by `RPC.response()`

If no nodes are reachable satisfying the provided `node:` identifier, `RPC.execute` will set `RPC.status: :not_reachable`.

`RPC.response()` extracts the response if `RPC.status: executed` to `{:ok, RPC.resp_body}`. If the current status `RPC.status` is different from `:executed`, it returns `{:error, :not_executed}`.
If the RPC response is on the form  `{:error, _} = function_error`. such `function_error` will be returned.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `relix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:relix, "~> 0.1.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/relix>.
