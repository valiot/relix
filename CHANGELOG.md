# CHANGELOG

## 0.1.5 [2026-06-13]

- [Bug Fix] Handle `:exit` (e.g. `{:exception, :terminating}`) and `:throw` from `erpc.call` in `Relix.RPC.execute/1` (OPS-4536). Previously these propagated as unhandled exits, crashing callers such as `TokenHelper.authorize_token_via_rpc`.

## 0.1.4 [2026-04-02]

- [Bug Fix] Improve RPC error logging to include module, function, arity, and exception message.

## 0.1.3 [2024-08-20]

- [Bug Fix] Wildcard node naming now ensures matching nodes starts with `wildcard@`.

## 0.1.2 [2024-05-15]

- [New Feature] Added `Relix.RPC.execute!` to throw an error on failed execution.

## 0.1.1 [2024-04-15]

- [New Feature] Now `Relix.RPC` accepts `node: :self` for self node requesting.

## 0.1.0 [2024-03-31]

- [New Feature] Added `Relix.RPC`.
