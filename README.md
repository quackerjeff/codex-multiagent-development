# Codex Multi-Agent Development Sample

A sample repository for multi-agent development workflows with Codex. It provides a spec-driven process, role-based delegation, and supporting repository guidance for teams that want a structured AI-assisted development workflow.

The main entry point is [AGENTS.md](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/AGENTS.md). It tells Codex how to run the workflow, where to store specs, which role cards to use, and which steering docs to follow.

This repository is an example, not a default you should copy unchanged. Review the role prompts, steering rules, and guardrails before using them in a real project.

## Overview

This sample keeps eight core roles:

| Role | Responsibility |
|------|----------------|
| `architect` | Research, planning, spec creation, orchestration |
| `ui-designer` | User flows, visual hierarchy, interaction states, frontend handoff |
| `coder` | Feature implementation and tests |
| `ops` | Infrastructure, CI/CD, containers, operational changes |
| `reviewer` | Correctness, maintainability, and spec compliance review |
| `qa-engineer` | Validation strategy, regression coverage, scenario testing, release confidence |
| `security-reviewer` | Security-only review |
| `docs` | README, architecture docs, runbooks, and inline docs |

Typical flow:

```text
architect -> ui-designer + coder + ops -> reviewer -> security-reviewer + qa-engineer -> docs -> architect
```

When Codex subagents are available in your environment, the architect should delegate parallel work using the role cards in `agents/`. When subagents are not available, Codex can still follow the same workflow sequentially.

For product-surface work, `ui-designer` should usually participate before code is finalized so `coder` is implementing a defined interaction rather than inventing one. For non-trivial delivery work, `qa-engineer` should validate behavior after implementation instead of treating code review alone as the release gate.

## Repository Model

This sample uses a few simple conventions:

| Concern | Convention |
|---------|------------|
| Repository instructions | `AGENTS.md` |
| Role definitions | Markdown role cards in `agents/` |
| Active spec work | `.codex/specs/...` |
| Reusable workflows | Prompt templates in `prompts/` |
| Policy enforcement helpers | Guardrail scripts in `scripts/guardrails/` |

## Quick Start

1. Put this directory at the root of the project you want Codex to work on, or copy its contents into an existing repository.
2. Make the guardrail scripts executable:

```bash
chmod +x scripts/guardrails/*.sh
```

3. Start Codex in the repository root:

```bash
codex
```

4. Ask Codex to read [AGENTS.md](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/AGENTS.md) and begin with one of the workflow prompts in `prompts/`.

Example:

```text
Read AGENTS.md, then use prompts/scope.md to open a new spec for ...
```

## Repository Structure

```text
├── AGENTS.md                # Codex repository instructions and orchestration rules
├── agents/                  # Role cards for architect, ui-designer, coder, reviewer, qa-engineer, ops, docs
├── prompts/                 # Reusable workflow prompts to paste into Codex
├── steering/                # Global behavioral rules referenced by AGENTS.md
├── skills/                  # Agent-agnostic domain knowledge files
├── scripts/guardrails/      # Standalone guardrail utilities for wrappers/CI/git hooks
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
└── LICENSE
```

## Specs and Issues

Specs live under `.codex/specs/`:

```text
.codex/specs/currentspec.md
.codex/specs/YYYY-MM-DD-<slug>/
  spec.md
  tasks.md
  review.md
  security-review.md
  qa.md
  decisions.md
```

This repository includes a complete example spec at [`.codex/specs/2026-07-12-account-settings-refresh/`](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/.codex/specs/2026-07-12-account-settings-refresh/) showing how `ui-designer`, `coder`, `reviewer`, `security-reviewer`, `qa-engineer`, and `docs` fit together in one realistic feature workflow.

Issue investigation folders live at:

```text
issues/YYYY-MM-DD-<slug>/
  report.md
  summary.md
```

## Guardrails

The guardrails are provided as standalone scripts rather than assuming a specific runtime hook system.

Use them in one of three ways:

1. From a thin local wrapper around `codex`
2. From git hooks or pre-commit checks
3. From CI jobs that validate generated changes

See [scripts/guardrails/README.md](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/scripts/guardrails/README.md).

## Prompts

The files in `prompts/` are reusable workflow definitions:

| Prompt | Purpose |
|--------|---------|
| `scope.md` | Start a new spec and task plan |
| `execute.md` | Run the active spec to completion |
| `diagnose.md` | Test-first bug fixing from `issues/` reports |
| `flywheel.md` | Review correction patterns and improve repo guidance |

Treat these as prompt templates: paste them into the session or tell Codex to follow a specific file.

## Skills

The `skills/` directory is copied over unchanged because it is already agent-agnostic. Those files work as reference material regardless of which coding agent is driving the session.

## UI Design

UI design is treated as a first-class role in this Codex sample. Use [agents/ui-designer.md](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/agents/ui-designer.md) together with [steering/frontend-design.md](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/steering/frontend-design.md) when a spec changes user-facing screens, flows, or component behavior.

## Quality Engineering

Quality engineering is distinct from code review in this sample. Use [agents/qa-engineer.md](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/agents/qa-engineer.md) together with [steering/quality-engineering.md](/Users/jeffrey/Development/AI/sample-codex-multiagent-development/steering/quality-engineering.md) when a spec needs scenario validation, regression coverage, or a clearer release-confidence signal.
