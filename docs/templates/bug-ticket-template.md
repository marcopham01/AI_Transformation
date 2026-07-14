# Bug Ticket Template (Bug branch)

Used when AI classifies a meeting-note item as a Bug (Sheet "Feedback vs. Bug
Detail"). Ticket type: **Bug**.

```
Title: [School name] — [short description of the bug]

Component/Label: <business module, e.g. Orders>
Source: meeting-YYYY-MM-DD-schoolcode

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

**BA checkpoint:** same as Feature tickets — reviewed and confirmed in the
Phase 2 summary table before moving to In Progress.

**Reminder:** the Issue Link must be an actual Jira Issue Link
("is caused by" → original ticket), not just a text reference in the
description — this is what lets Dev/QC navigate ticket history quickly.
