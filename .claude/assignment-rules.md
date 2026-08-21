# Auto-Assignment Rules (parent ticket + subtasks)

How Claude Code assigns work when it creates a ticket in Phase 2.

**Model:** the parent ticket (Task or Bug) is a *container* and is **not
assigned to anyone**. Claude Code creates **subtasks** under it — one per
discipline actually needed (BE / FE / Mobile / QC) — and assigns each
subtask to a person by discipline + load.

References `naming-conventions.md` (priority values, branch/label formats)
and `bug-ticket-template.md` (original-ticket lookup).

Timing: subtasks are created and assigned at ticket-creation time (Phase 2),
except QC — see Rule QC. Per the Rollout Roadmap, Dev work is Month 2; these
rules take effect when the Dev pilot starts.

---

## Which subtasks to create (per parent)

Decide from the ticket content — do **not** blindly split everything.

**Feature (Task):**
- **BE subtask** if the feature needs API / data / business logic.
- **FE subtask** if the feature needs a screen / UI.
- **Mobile subtask** only if the note explicitly mentions the mobile app.
- Most new features need **BE + FE**. A pure-API feature may be BE only; a
  pure-display tweak may be FE only. Read the note.
- **QC subtask: always.**

**Bug:**
- Create a subtask for **the discipline where the defect is**: UI/display
  bug → FE; API/data/logic bug → BE; mobile-app bug → Mobile.
- If the layer is unclear from the note, create the most likely one and flag
  it for BA (`Subtask note: defect layer uncertain — assumed <BE/FE>, confirm.`).
- **QC subtask: always** (to verify the fix).

**Note subtask:** if the note calls for documentation/changelog work, add a
Note subtask (unassigned or to the BA) — optional, only when the note asks.

If a needed discipline has no person in the roster (e.g. Mobile today),
create the subtask but leave it Unassigned and flag:
`Assign note: no <discipline> member in roster — assign manually.`

## Load measure (per person)

A person's load = **sum of priority weights of their open subtasks/tickets**
(any status not Done):

| Priority | Weight |
|---|---|
| Highest | 5 |
| High | 4 |
| Medium | 3 |
| Low | 2 |
| Lowest | 1 |

Subtasks inherit the parent's priority unless set otherwise. "Least-loaded"
= lowest total weight, not fewest items.

## Overload cap

**Cap = 12 load points** (~4 Medium). At/under 12 = available; over 12 =
overloaded. Pilot starting value — retune with real data.

## Assignment per subtask

Assign **within the subtask's discipline only** — an FE subtask considers
only FE people, BE only BE, QC only QC.

### Rule A — Bug-fix subtask (context first)
1. Find the parent bug's original ticket (Component/Label + Rovo search; see
   `bug-ticket-template.md`).
2. Read that ticket's assignee / its subtask assignee **in the same
   discipline**.
3. Decide:
   - Prior person found in this discipline **and** load ≤ 12 → assign to them
     (keeps module context).
   - Found **but** load > 12 → load-balance within discipline (Rule C), flag:
     `Assign note: <name> (module owner) overloaded, load-balanced within <discipline>.`
   - None found / was Unassigned → load-balance within discipline (Rule C),
     flag:
     `Assign note: no prior <discipline> owner found — load-balanced; dev should read code directly.`

### Rule B — Feature subtask (load balance)
No prior context → load-balance within discipline (Rule C).

### Rule C — Load balance within a discipline
1. Compute each person's load **in that discipline**.
2. Assign to the least-loaded.
3. Tie → deterministic pick (alphabetical by display name).
4. All in that discipline over cap → still pick least-loaded, flag:
   `Assign note: all <discipline> members over capacity — BA may want to rebalance.`

### Rule QC — QC subtask
- QC subtask is **created at Phase 2** with the parent, but **assigned when
  the parent moves to Testing**, not at creation (nothing to test yet).
- Assign within QC discipline using Rule A/C logic (prefer whoever QC'd a
  related ticket, else load-balance).

## Hard rules for Claude Code

1. **Parent ticket is never assigned.** Only subtasks carry a person.
2. **Never assign silently wrong.** Assign only to real roster members of the
   correct discipline. No silent blanks — any "no assignee" is an explicit
   flag (Mobile today, or all-overloaded).
3. **Use account IDs from the roster**, never guess by display name — several
   names are near-identical, only the account ID disambiguates.
4. **Always record an `Assign note:`** on each assigned subtask stating why
   (module owner / load balance / one of the flags). This is what the BA
   reviews at the Phase 2 checkpoint.
5. **Load is read live** from Jira at assignment time — never cached. If loads
   can't be read, stop and flag rather than guess.
6. **Roster must match the Jira group.** AI can't read Jira groups (scope is
   `jira-work` only, not admin), so this file's roster is the source of truth
   for who is FE/BE/Mobile/QC. When people change, update **both** the Jira
   group **and** this roster.
7. **Cap/weights are configurable pilot values**, changed only here.

## Team roster (source of truth for discipline + assignment)

> AI reads account IDs from here to assign. Keep in sync with the Jira Dev/QC
> groups. Replace `<account-id-...>` with the real IDs from
> `lookupJiraAccountId` before relying on auto-assign.

| Display name | Account ID | Role | Discipline | Telegram chat_id |
|---|---|---|---|---|
| Nam Phạm | 712020:00638aa2-ee3c-42b4-8384-2169fee560f2 | Dev | BE | 7576118866 |
| Phương Nam Phạm | 712020:ec203f5c-14e1-49bb-8b7b-06c949d6ad0d | Dev | FE | 7576118866 |
| Phạm Nam | 712020:fac60a14-516f-4ade-bcd3-0014efa9d532 | QC | QC | 7576118866 |
| _(none yet)_ | — | Dev | Mobile | — |

Notes:
- **Mobile has no member yet** → Mobile subtasks stay Unassigned + flagged
  until a Mobile dev is added here and to the Jira group.
- Account IDs are the ONLY reliable key — the three Vietnamese names are very
  similar and several accounts have no email shown in Jira.
- **Telegram chat_id** is used by the notification step (see CLAUDE.md). During
  the pilot test all three point to the BA's own chat_id (7576118866) — replace
  each with the person's real chat_id at rollout (each dev DMs the bot once,
  then read their id from getUpdates).
- To add someone: add them to the Jira project + the correct Jira group,
  then add a row here with their account ID, discipline, and Telegram chat_id.

## Prerequisites (why this may not fully run yet)

- Real users must be project members (they are: 2 Dev + 1 QC).
- Ticket history needs real assignees for Rule A (bug context) to help. On a
  fresh board, bugs fall through to load-balance until history builds — normal
  early on.
- Project key is now **AIAT** (renamed from KAN) — make sure JQL/prompts use
  `project = AIAT`.
