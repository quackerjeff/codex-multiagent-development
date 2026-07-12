---
inclusion: always
---

# Frontend Design

## Principle

UI work must be designed deliberately before or alongside implementation. A frontend task is incomplete if the engineer has to invent layout, state behavior, copy hierarchy, or accessibility rules on the fly.

## When to Add a UI Design Task

Add a dedicated `ui-designer` task when work includes any of the following:

- New screens, dashboards, forms, wizards, or navigation structures
- Significant layout changes to existing user-facing pages
- New reusable component patterns
- Flows with meaningful empty, loading, or error-state behavior
- Mobile responsiveness or accessibility requirements that need explicit design decisions

## Required Design Output

UI design tasks should produce implementation-ready guidance, usually in `docs/ui/<slug>.md` or directly in the spec:

- User goal and primary interaction flow
- Screen or component structure
- State definitions: default, hover/focus, disabled, loading, success, error, empty
- Responsive behavior notes
- Accessibility requirements
- Handoff notes for engineering

If visuals are simple, markdown wireframes or structured bullet layouts are enough. Use heavier artifacts only when the problem actually needs them.

## Task Planning Rule

If a spec contains meaningful frontend or product-surface work, the plan should usually include:

1. Research group
2. UI design group or task
3. Implementation groups
4. Review gate
5. Documentation group

Small UI tweaks can combine design and implementation in the same group only when the acceptance criteria still remove ambiguity.

## Acceptance Criteria for UI Design Tasks

Every UI design task should specify:

- What user flow or surface is being designed
- Which states must be covered
- Which files will consume the design guidance
- How the handoff will be verified

Example:

```markdown
- [ ] Design the onboarding flow and component states | `docs/ui/onboarding.md`
  - **Accept**: Guidance covers layout, copy hierarchy, validation, loading/error/success states, mobile behavior, and accessibility notes for the onboarding flow
  - **Verify**: `rg -n 'loading|error|empty|accessibility|mobile' docs/ui/onboarding.md`
  - **Constraints**: Reuse existing navigation and form patterns where possible; do not invent a parallel design system
```
