# Guardrail Scripts

These scripts provide optional policy enforcement and logging helpers for this repository.

Codex does not read a repo-local hook manifest here, so treat these as standalone utilities:

- call them from a local wrapper around `codex`
- wire them into git hooks
- run them from CI before accepting generated changes

## Event Format

Most scripts intentionally keep the original JSON-on-stdin contract so they can be called from a thin Codex wrapper or CI harness without much glue.

Typical payloads:

```json
{"cwd":"/path/to/repo","prompt":"user text"}
{"cwd":"/path/to/repo","assistant_response":"assistant text"}
{"tool_input":{"command":"terraform destroy"}}
{"tool_input":{"ops":[{"path":"package.json","content":"..."}]}}
```

`validate-environment.sh` is the exception: it can be run directly with no payload.

The flywheel scripts are optional logging helpers. If you build a wrapper around Codex, point them at `~/.codex/`.
