# Contributing / Conventions

These conventions exist so Claude Code (and humans) produce consistent code
without needing to re-derive style choices on every ticket. Update this file
as the team's real preferences emerge — treat the first pilot tickets as the
source of truth, not this initial draft.

## Branch naming

One branch per Jira ticket, created by whoever/whatever picks up the ticket:

```
feature/AIAT-123-short-kebab-description
bug/AIAT-124-short-kebab-description
```

- Ticket key first so it's traceable from the branch list alone.
- Lowercase, hyphen-separated description, no more than ~5 words.

## Commit messages

Conventional-commit style, one logical change per commit:

```
feat(orders): add validation for missing school ID
fix(orders): correct duplicate-order check on resubmit
```

When Claude Code authors a commit, it appends its standard trailer:

```
Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

Leave this trailer in place — it's how reviewers can tell which commits were
AI-authored versus human-authored during the pilot.

## Backend (Go)

- Formatting: `gofmt` / `goimports` before every commit — no manual style debates.
- Linting: `golangci-lint run` should pass with no new warnings.
- Package layout: standard Go project layout —
  `backend/cmd/`, `backend/internal/`, `backend/pkg/` as the app grows past a
  single main package.
- Error handling: return errors, don't panic in request-handling code; wrap
  errors with context (`fmt.Errorf("creating order: %w", err)`).
- Tests: table-driven tests using the standard `testing` package, file named
  `<subject>_test.go` next to the code it tests. New endpoints need at least
  one happy-path test and one validation/error-path test.

## Frontend (React)

- Functional components + hooks only, no class components.
- One component per file, named the same as the file (`OrderForm.jsx` →
  `OrderForm`).
- Folder-by-feature under `frontend/src/features/orders/` rather than
  folder-by-type, so the Create/View order feature stays self-contained.
- Tests: React Testing Library + Jest, one test file per component
  (`OrderForm.test.jsx`), covering render + primary user interaction.

## Definition of done for an AI-authored PR (Phase 3 checkpoint)

Before Claude Code moves a ticket to **Dev Done**, the PR description must
include: what changed, why (linking the Jira ticket), how it was tested, and
any risks/assumptions the Dev should double-check. This is the report the Dev
reviews at the single Phase 3 checkpoint (step 3.7).
