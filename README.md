
![Relix Logo](https://github.com/valiot/relix/blob/a19b7019305a8e560d4fb19f235b819aaa912a9b/priv/static/images/relix.png)

# Relix

![Valiot - Tech](https://img.shields.io/badge/Valiot-Tech-blue.svg?style=flat-square&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2ZXJzaW9uPSIxLjEiIHdpZHRoPSIxMDAwIiBoZWlnaHQ9IjEwMDAiIHZpZXdCb3g9IjAgMCAxMDAwIDEwMDAiIHhtbDpzcGFjZT0icHJlc2VydmUiPgo8ZGVzYz5DcmVhdGVkIHdpdGggRmFicmljLmpzIDMuNS4wPC9kZXNjPgo8ZGVmcz4KPC9kZWZzPgo8cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJyZ2JhKDAsMCwwLDApIi8+CjxnIHRyYW5zZm9ybT0ibWF0cml4KDIyLjc4ODcgMCAwIDIyLjc4ODcgODY4Ljc3OTggNTAwLjQ0MjMpIiBpZD0iUGF0aF83IiBjbGlwLXBhdGg9InVybCgjQ0xJUFBBVEhfNCkiPgo8Y2xpcFBhdGggaWQ9IkNMSVBQQVRIXzQiPgoJPHJlY3QgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSAxNi42ODA2IC0wLjAxOTQpIiBpZD0iU1ZHSURfMDAwMDAxODMyMDg5MzM5Njg1NTk2MTc4NjAwMDAwMDM2ODQ5MTQ5NzA0NjEzMzA1OTlfIiB4PSItNTQuMzUiIHk9Ii0xMS4yIiByeD0iMCIgcnk9IjAiIHdpZHRoPSIxMDguNyIgaGVpZ2h0PSIyMi40Ii8+CjwvY2xpcFBhdGg+CjxwYXRoIHN0eWxlPSJzdHJva2U6IG5vbmU7IHN0cm9rZS13aWR0aDogMTsgc3Ryb2tlLWRhc2hhcnJheTogbm9uZTsgc3Ryb2tlLWxpbmVjYXA6IGJ1dHQ7IHN0cm9rZS1kYXNob2Zmc2V0OiAwOyBzdHJva2UtbGluZWpvaW46IG1pdGVyOyBzdHJva2UtbWl0ZXJsaW1pdDogNDsgaXMtY3VzdG9tLWZvbnQ6IG5vbmU7IGZvbnQtZmlsZS11cmw6IG5vbmU7IGZpbGw6IHJnYig4MCwyNTAsMTIpOyBmaWxsLXJ1bGU6IG5vbnplcm87IG9wYWNpdHk6IDE7IiB0cmFuc2Zvcm09IiB0cmFuc2xhdGUoLTM4LjE2OTQsIC0xMS45MTk0KSIgZD0iTSA0My4zIDIwLjQgTCAzNi43IDIgYyAtMC40IC0xIC0xLjUgLTEuNSAtMi41IC0xLjIgYyAtMSAwLjQgLTEuNSAxLjUgLTEuMiAyLjUgbCAwIDAgbCA2LjYgMTguNSBjIDAuNCAxIDEuNSAxLjYgMi41IDEuMiBTIDQzLjcgMjEuNSA0My4zIDIwLjQgTCA0My4zIDIwLjQiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgo8L2c+CjxnIHRyYW5zZm9ybT0ibWF0cml4KDIyLjc4ODcgMCAwIDIyLjc4ODcgMzAxLjQ0OTggNDk3LjQ4NjUpIiBpZD0iUGF0aF84IiBjbGlwLXBhdGg9InVybCgjQ0xJUFBBVEhfNSkiPgo8Y2xpcFBhdGggaWQ9IkNMSVBQQVRIXzUiPgoJPHJlY3QgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSA0MS41NzU4IDAuMTEwMykiIGlkPSJTVkdJRF8wMDAwMDE4MzIwODkzMzk2ODU1OTYxNzg2MDAwMDAwMzY4NDkxNDk3MDQ2MTMzMDU5OV8iIHg9Ii01NC4zNSIgeT0iLTExLjIiIHJ4PSIwIiByeT0iMCIgd2lkdGg9IjEwOC43IiBoZWlnaHQ9IjIyLjQiLz4KPC9jbGlwUGF0aD4KPHBhdGggc3R5bGU9InN0cm9rZTogbm9uZTsgc3Ryb2tlLXdpZHRoOiAxOyBzdHJva2UtZGFzaGFycmF5OiBub25lOyBzdHJva2UtbGluZWNhcDogYnV0dDsgc3Ryb2tlLWRhc2hvZmZzZXQ6IDA7IHN0cm9rZS1saW5lam9pbjogbWl0ZXI7IHN0cm9rZS1taXRlcmxpbWl0OiA0OyBpcy1jdXN0b20tZm9udDogbm9uZTsgZm9udC1maWxlLXVybDogbm9uZTsgZmlsbDogcmdiKDAsMTYyLDI1NSk7IGZpbGwtcnVsZTogbm9uemVybzsgb3BhY2l0eTogMTsiIHRyYW5zZm9ybT0iIHRyYW5zbGF0ZSgtMTMuMjc0MiwgLTExLjc4OTcpIiBkPSJNIDI2IDEuNyBjIC0yLjUgLTEuNyAtNS45IC0xIC03LjYgMS41IGMgLTAuMyAwLjQgLTAuNSAwLjggLTAuNiAxLjIgbCAtMi42IDcuNCBsIC0wLjUgMS4zIGMgMCAwIC0xLjUgNC4zIC0xLjYgNC40IGMgLTAuMiAwLjcgLTAuOSAxLjEgLTEuNyAxLjEgYyAtMC43IDAgLTEuMyAtMC40IC0xLjYgLTEuMSBjIC0wLjEgLTAuMSAtMS42IC00LjQgLTEuNiAtNC40IEwgNC40IDIgQyA0IDEgMi45IDAuNCAxLjggMC44IFMgMC4zIDIuMyAwLjcgMy4zIGMgMCAwIDAgMCAwIDAgbCAzLjUgOS44IGwgMi4yIDYuMSBjIDAuOCAyLjIgMi44IDMuNyA1LjIgMy43IGMgMi40IDAuMSA0LjUgLTEuNCA1LjIgLTMuNiBsIDIgLTUuOCBsIDEgLTIuOSBsIDEuOCAtNS4xIEMgMjIuMiAzLjQgMjMuOSAxLjkgMjYgMS43IiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KPC9nPgo8ZyB0cmFuc2Zvcm09Im1hdHJpeCgyMi43ODg3IDAgMCAyMi43ODg3IDY2Ni4wOTE3IDUzNC42MjUzKSIgaWQ9IlBhdGhfOSIgY2xpcC1wYXRoPSJ1cmwoI0NMSVBQQVRIXzYpIj4KPGNsaXBQYXRoIGlkPSJDTElQUEFUSF82Ij4KCTxyZWN0IHRyYW5zZm9ybT0ibWF0cml4KDEgMCAwIDEgMjUuNTc0OCAtMS41MTk0KSIgaWQ9IlNWR0lEXzAwMDAwMTgzMjA4OTMzOTY4NTU5NjE3ODYwMDAwMDAzNjg0OTE0OTcwNDYxMzMwNTk5XyIgeD0iLTU0LjM1IiB5PSItMTEuMiIgcng9IjAiIHJ5PSIwIiB3aWR0aD0iMTA4LjciIGhlaWdodD0iMjIuNCIvPgo8L2NsaXBQYXRoPgo8cGF0aCBzdHlsZT0ic3Ryb2tlOiBub25lOyBzdHJva2Utd2lkdGg6IDE7IHN0cm9rZS1kYXNoYXJyYXk6IG5vbmU7IHN0cm9rZS1saW5lY2FwOiBidXR0OyBzdHJva2UtZGFzaG9mZnNldDogMDsgc3Ryb2tlLWxpbmVqb2luOiBtaXRlcjsgc3Ryb2tlLW1pdGVybGltaXQ6IDQ7IGlzLWN1c3RvbS1mb250OiBub25lOyBmb250LWZpbGUtdXJsOiBub25lOyBmaWxsOiByZ2IoODAsMjUwLDEyKTsgZmlsbC1ydWxlOiBub256ZXJvOyBvcGFjaXR5OiAxOyIgdHJhbnNmb3JtPSIgdHJhbnNsYXRlKC0yOS4yNzUyLCAtMTMuNDE5NCkiIGQ9Ik0gMzMuOCAyMC40IEwgMjguNCA1LjEgYyAtMC40IC0xIC0xLjUgLTEuNSAtMi41IC0xLjIgcyAtMS41IDEuNSAtMS4yIDIuNSBsIDUuNCAxNS4zIGMgMC40IDEgMS41IDEuNiAyLjUgMS4yIEMgMzMuNyAyMi42IDM0LjIgMjEuNSAzMy44IDIwLjQiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgo8L2c+Cjwvc3ZnPg==)
![version - 0.1.2](https://img.shields.io/badge/version-0.1.2-white.svg?style=flat-square&color=lightgray)

**Remote Execution Library for Elixir**

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
