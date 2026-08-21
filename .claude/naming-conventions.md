# Naming Conventions (single source of truth)

All ticket + meeting-record templates reference this file so the same
formats are used everywhere. If a rule here conflicts with a template, this
file wins — update the template to match.

Applies to: `ba-meeting-note-template.md`, `feature-ticket-template.md`,
`bug-ticket-template.md`.

---

## 1. Ticket title

Format: `[School] — [verb + object]`

- Start with a **verb**; keep it short and action-oriented.
- Use an em dash `—` between the school name and the description.
- Description is written in Vietnamese (matches the real tickets), but the
  format itself is fixed.

Examples:
- `FPTU — Tạo đơn xác nhận sinh viên`
- `FPTU — Xem lại lịch sử đơn của sinh viên`
- `Tô Ngọc Vân — Sửa lỗi mất dữ liệu phân công giảng dạy` (Bug)

Abbreviate the school name consistently (e.g. always `FPTU`, never mixing
`FPT` / `ĐH FPT`). If a school has no agreed abbreviation, use the shortest
unambiguous full name.

## 2. Component / Label

- **Vietnamese with diacritics**, named after the business module the way
  users refer to it.
- Noun phrase, first letter capitalized.
- Examples: `Đơn xác nhận sinh viên`, `Học bạ`, `Đơn hàng`,
  `Phân công giảng dạy`.
- **One module = one fixed Component.** Do not create variants (`Đơn xác nhận
  SV` vs `Đơn xác nhận sinh viên` is WRONG — pick one spelling and keep it).
- When a new module has no Component yet → **propose a new Component for a
  human to approve**; never dump it into a generic catch-all Component
  ("Khác" / "General" / "Other").

> Why Vietnamese with diacritics: the Bug branch finds the original ticket by
> Component, and BA/Dev read the Component to identify the module — a
> Vietnamese name matches how people refer to it in meetings and reduces
> mismatch. The trade-off is that spelling must stay consistent (correct
> diacritics, correct capitalization).

## 3. Meeting label (= the `Source:` field in a ticket)

Format: `meeting-YYYY-MM-DD-<schoolcode>`

- `<schoolcode>`: lowercase, no diacritics, no spaces (e.g. `fptu`).
- Example: `meeting-2026-07-15-fptu`
- **The `Source:` field in a ticket and the `Meeting label:` in a meeting
  record are the SAME value.** A ticket must carry the label of the meeting
  that produced it — Phase 5 uses this to find the record again and write
  status back into it.

## 4. Mockup image filenames

Format: `mockup-<N>-<screen-name>.png`

- `<N>`: screen sequence number (1, 2, 3...).
- `<screen-name>`: **kebab-case, no diacritics**, short description of the
  screen.
- Examples: `mockup-1-tao-don.png`, `mockup-2-xem-don.png`,
  `mockup-3-duyet-don.png`.
- Mockup files are **attached to the Jira ticket**; the UI—wireframe section
  of the ticket must include a line pointing to the exact filename.
- No mockup yet → still draw the ASCII wireframe and mark the file as `TODO`.

## 5. Branch name (when Dev/AI writes code — matches CONTRIBUTING.md)

Format: `feature/AIAT-<number>-<short-desc>` or `bug/AIAT-<number>-<short-desc>`

- `<short-desc>`: kebab-case, no diacritics, ≤5 words.
- Example: `feature/AIAT-12-tao-don-xac-nhan-sv`
- Ticket key first, so a branch is traceable from the branch list alone.

## 6. Priority (shared value set)

Valid values (exactly as in the Jira dropdown): **Highest, High, Medium,
Low, Lowest.**

- **Bug (production) → default Highest** unless told otherwise.
- **Feature/Task → by how urgently it's needed**, read from the meeting note:
  - Urgent / has a deadline / blocking their work → **High** or **Highest**.
  - Enhancement / nice-to-have / future work → **Low** or **Medium**.
  - Unclear → **Medium** + note "priority needs BA confirmation". Do NOT
    guess.
- Always include a one-line `Priority reason:` quoting the cue from the
  meeting note.

## 7. Language

- **Ticket body + meeting records: Vietnamese** (matches the real tickets and
  how schools phrase things).
- Meta guidance inside templates (the `<...>` instruction notes): English,
  keep as-is.
- Component: Vietnamese with diacritics (section 2). Meeting label / mockup
  filename / branch name: no diacritics (sections 3, 4, 5).
