# CLAUDE.md — Project instructions for Claude Code

This is the AI agentic workflow pilot for the product team. Scope: **Create
order / View order** and equivalent low-risk features. Payment, grading, and
student-data features are out of scope.

When I give you a task, follow the conventions in `docs/templates/` — you do
**not** need me to re-list the steps each time. The short prompt is enough;
the process below is the standing instruction.

## Default workflow: turning a meeting record into tickets (BA / Phase 2)

When I point you at a meeting record (a Google Drive file, an uploaded file,
or pasted text) and ask you to process / handle / turn it into tickets:

1. **Read the record.** From Google Drive if I name a Drive file (search for
   it, read its content); otherwise from what I give you.
2. **Review it first** using `docs/ai-note-review-checklist.md`.
   Surface any unclear items or excluded-scope (PII / grading / student data)
   as short suggestions for me — do not silently fix or assume. If it's
   clean, say so and continue.
3. **Create tickets** following `docs/templates/feature-ticket-template.md`
   or `docs/templates/bug-ticket-template.md` (classify Feature vs Bug by the
   cues in `ba-meeting-note-template.md`).
4. **Naming / labels / priority**: follow
   `docs/rules/naming-conventions.md` (title format, Vietnamese-with-
   diacritics Component, meeting label = Source, module-family label,
   priority rules).
5. **Subtasks + assignment**: follow `docs/rules/assignment-rules.md`
   (parent unassigned; split BE/FE/QC as needed; assign each subtask by
   discipline using context-first then load-balance; always write an
   `Assign note:`; QC assigned later at Testing).

## Standing guardrails (always, unless I explicitly say otherwise)

- **Stop before side effects.** Create tickets and propose assignees, but do
  **not** transition status, merge, or move existing work. Leave that for my
  review at the Phase 2 checkpoint.
- **Never auto-reassign in-flight work.** For overload, raise an offload
  *proposal* for me (Rule D) — don't move anyone's existing task.
- **Excluded scope stops the auto-flow.** If an item touches grading/scoring,
  student personal data, transcripts, or admissions ranking, flag it for the
  stricter manual-confirmation process instead of creating tickets.
- **Report, then wait.** After creating tickets/subtasks, summarise what you
  made and how you assigned it, then stop for my review.

## Project facts

- Jira project key: **AIAT** (renamed from KAN).
- Team roster (who is FE/BE/QC) lives in `docs/rules/assignment-rules.md`
  — that file is the source of truth, since you can't read Jira groups.
- Components aren't enabled on this Jira project → use **labels** in their
  place (already reflected in the conventions).

## Notifications (Telegram) — after BA confirmation

Assignees are notified on Telegram, but **only after the BA confirms the ticket
list** at the Phase 2 checkpoint. Never notify at ticket-creation time. This
keeps to "AI proposes, BA decides" and avoids pinging people if an assignment
was wrong.

### When to send
- Trigger: the BA has explicitly confirmed the ticket list for this batch.
- Scope: every subtask that (a) has a real assignee AND (b) whose assignee has
  a Telegram chat_id in the roster (assignment-rules.md).
- QC subtasks are assigned later (Rule QC — at the Testing transition), so
  notify QC right after the QC subtask is actually assigned, not at Phase 2.
- Mobile / any Unassigned subtask: no notification (no assignee). The existing
  Assign-note flag already covers it for the BA.

### How to send
For each subtask in scope:
1. Read the assignee's Telegram chat_id from the roster in assignment-rules.md.
2. No chat_id listed -> skip and flag:
   "Notify note: no Telegram chat_id in roster for <name> — notify manually."
3. Otherwise run one message per assigned subtask:
   bash scripts/notify_assignee.sh <chat_id> "<message>"

### Message template
The message body should follow this shape:
- Line 1: "<AIAT-key>: <subtask summary> — đã assign cho bạn"
- Line 2: "Discipline: <BE/FE/QC> · Priority: <priority>"
- Line 3: "https://marcopham01.atlassian.net/browse/<AIAT-key>"

### Hard rules
1. Never notify before BA confirmation. No exceptions.
2. One message per assigned subtask, sent once. Do not re-notify on later edits
   unless the BA asks.
3. chat_id comes from the roster only — never guess. Missing chat_id -> flag.
4. Notification is a side-effect only — it never changes ticket state.
5. If the send fails, flag for the BA rather than continuing silently:
   "Notify note: Telegram send failed for <AIAT-key> (<name>) — check bot/token."