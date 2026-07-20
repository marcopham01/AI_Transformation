# Bug Ticket Template (Bug branch)

> Đặt tên (title, Component, mockup, meeting label, priority) tuân theo docs/templates/naming-conventions.md.

Used when AI classifies a meeting-note item as a Bug (Sheet "Feedback vs. Bug
Detail"). Ticket type: **Bug**.

> **Note:** a Bug ticket represents a **production bug** — something already
> live that the school is hitting now, not a not-yet-built feature. That's why
> its default priority is the highest (see priority rules below).

```
Title: [School name] — [short description of the bug]

Component/Label: <business module, e.g. Orders>
Source: meeting-YYYY-MM-DD-schoolcode
Issue type: Bug
Priority: <Highest | High | Medium | Low | Lowest — required; default Highest, see priority rules below>
Priority reason: <one line quoting the cue from the meeting note that justifies the chosen priority, so the BA can review it at the Phase 2 checkpoint>

## Original ticket lookup
Searched by Component/Label and read the description + comments of the
original ticket before filing this bug.
- [ ] Original ticket found: <ticket key> — Issue Link "is caused by" attached
- [ ] No related original ticket found — Dev should read the code directly,
      no Issue Link attached

## What's broken (from meeting note)
<restated description of what the school reported>

## Reproduction steps (best guess from meeting note — Dev/QC to confirm)
1. <step>
2. <step>

## Expected vs actual
- Expected: <what should happen>
- Actual: <what happens instead>
```

## Strict rules for Claude Code

1. **Priority is required.** Valid values: **Highest, High, Medium, Low,
   Lowest.** A Bug is a production bug, so **default to Highest** — production
   bugs are always top priority unless the meeting note explicitly says
   otherwise. Only lower it below Highest when the note gives a clear reason to
   (e.g. cosmetic, low impact, already worked around).
2. **Always write the reason.** Fill the `Priority reason:` line with a
   one-line justification that quotes the cue from the meeting note, so the BA
   can review it quickly at the Phase 2 checkpoint.

**BA checkpoint:** same as Feature tickets — reviewed and confirmed in the
Phase 2 summary table before moving to In Progress.

**Reminder:** the Issue Link must be an actual Jira Issue Link
("is caused by" → original ticket), not just a text reference in the
description — this is what lets Dev/QC navigate ticket history quickly.
