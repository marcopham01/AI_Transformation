# Meeting Record Template — Standard Format (Phase 1 output / Phase 2 input)

> Đặt tên (title, Component, mockup, meeting label, priority) tuân theo docs/templates/naming-conventions.md.

This is the **finalized meeting record format** AI reads directly from
Google Drive in Phase 2 — based on the school's actual working format
(reference: "Tô Ngọc Vân" meeting record, 11/03/2026), not a generic
placeholder. It replaces the earlier quick-tick-box draft.

> **Scope reminder for whoever fills this in:** items about grading/scoring,
> student personal data, transcripts, or admissions ranking are **excluded
> from the current AI pilot** (Create order / View order only). Real
> meeting notes will likely contain a lot of these — that's expected and
> fine, but flag them so they route to the stricter manual-confirmation
> process instead of the Automate pipeline described below.

---

## Header (required, exact field names)

```
**Tên trường:** <school name>
**Thời gian:** <start time> – <end time>, ngày <date>
**Địa điểm:** <location>
**Thành phần:** <attendee list, comma-separated, roles in parentheses e.g. "Nhật Minh (BA)">
**Meeting label (Jira tagging):** meeting-YYYY-MM-DD-<schoolcode>
```

The `Meeting label` field is mandatory even though the source example
doesn't include it — Phase 5 needs it to find and update this record later
("AI checks ticket status ... fills status back into the original meeting
record").

## Body structure

Numbered sections by topic/business module, one per module raised in the
meeting (e.g. `### 1. Đồng bộ điểm tổng kết`). **Each section header should
map to a Jira Component/Label** — if a module doesn't have a Component yet,
AI should flag it as "unfamiliar module, suggest new Component" rather than
guessing (per your Phase 5 "suggestion only, human approves" rule).

Each bullet under a section is **one discrete item** raised at the meeting:

```
- <what was raised, in the school's own words>
```

**Important — timing of status markers:** when the file is first filled in
right after the meeting, bullets look like the line above, with **no**
`=>` marker yet. The `=> XONG` / `=> Sẽ đưa vào kế hoạch` / etc. markers you
see in real examples get added **later**, when someone revisits the file to
track what's been resolved — today that's the BA writing them in by hand,
which is exactly the manual habit Phase 5 aims to replace with AI. So a
freshly-captured record won't have these yet, and that's expected, not
missing data.

## Two read passes — first classification vs. later status re-check

**Pass 1 — Phase 2, first read of a fresh record (no markers present):**
Every bullet is a candidate. Classify purely on the Feedback/Bug wording
cues below; there's no marker to filter on yet.

**Pass 2 — Phase 5, later re-read of an already-worked record (markers now present):**
This is where markers matter — they prevent re-processing something already
handled. On this pass:

| Marker as typically written | Meaning | AI action |
|---|---|---|
| `=> XONG`, `Đã xong`, `Đã fix => Xong` | Already resolved, confirmed working | **Do not create a ticket** — it was already handled in Pass 1 or since. |
| `Theo kế hoạch` | Already scheduled / in progress on an existing plan | **Do not create a new ticket** — comment status on the existing ticket instead, if known. |
| `=> Sẽ đưa vào kế hoạch`, `Sẽ đưa thêm vào kế hoạch` | Ticket exists but still pending | **Do not create a duplicate** — this marker means a ticket was already filed in Pass 1; just leave it, or update status if changed. |
| `=> Cần kiểm tra lại`, `Cần theo dõi lại hệ thống` (paired with a problem description) | Someone flagged this as needing re-verification, possibly after an earlier fix | **Create/reopen a Bug ticket** — treat as a live regression even if a prior fix is mentioned nearby. |
| No marker | This item hasn't been worked yet | Treat as Pass 1 — classify normally. |

## Feedback vs. Bug classification (Pass 1, or any unmarked item found later)

**Bug cues** (Vietnamese, as actually used — any of these near an item → Bug branch):
`mất dữ liệu`, `bị lỗi`, `sai`, `nhảy điểm`, `bị nhảy`, `cần kiểm tra lại`, `check lại ... bị ...`

**Feedback / new-request cues**:
`muốn`, `mong muốn`, `yêu cầu`, `đề nghị`, `thêm`, `bổ sung`, `cho phép`, `mở cho`

Same downstream rules as your Jira ticket templates apply once classified:
- Bug branch → search original ticket by Component/Label, read its history,
  attach a real Issue Link ("is caused by"), or explicitly note "no related
  original ticket found" if none exists.
- Feedback branch → search for a pending duplicate before creating a new
  Feature/Story ticket.

## Strict rules for Claude Code

1. **Never invent a status marker.** A bullet with no `=>` marker is normal
   on a first read — classify and ticket it (Pass 1). Only skip ticketing
   when a marker is actually present and says not to.
2. **Never re-open a `XONG` item automatically** just because it resembles
   an open item elsewhere in the same record — only `Cần kiểm tra lại`-style
   markers justify treating a previously-fixed thing as a live bug.
3. **Section header = Component/Label**, always. If Claude Code can't match
   a section to an existing Component, it must stop and suggest one rather
   than filing under the wrong module or a generic catch-all.
4. **Excluded-scope check first, always.** Before classifying anything,
   check whether the item touches grading/scoring, attendance records used
   for compliance, student personal data, or transcripts. If yes, do not run
   the Automate ticket-creation flow — flag it for the stricter
   manual-confirmation process and stop.
5. **One ticket per bullet**, not one ticket per section — sections can
   contain a mix of already-done and pending items.

## Reference example — later-stage record (markers already added, Pass 2 scenario)

```
### 9. Phân công giảng dạy
- Mất dữ liệu phân công giảng dạy, cần kiểm tra lại. => Cần theo dõi lại hệ thống
- Cho phép phân công 2 giáo viên cho cùng một môn Nghệ thuật. => Sẽ đưa thêm vào kế hoạch
```
This is what the file looks like *after* someone has revisited it — not
what Phase 2 sees on the first pass. First bullet → still a live Bug (marker
says re-check needed). Second bullet → already ticketed as Feedback in
Pass 1; the marker here just confirms it's pending, not a new item to file.
