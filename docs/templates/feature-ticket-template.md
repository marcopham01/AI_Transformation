# Feature Ticket Template (Task) (Feedback branch)

> Đặt tên (title, Component, mockup, meeting label, priority) tuân theo docs/templates/naming-conventions.md.

Used when AI classifies a meeting-note item as Feedback/new request
(Sheet "Feedback vs. Bug Detail"). Ticket type: **Task** (the team uses
**Task** for new features / enhancements, not Story).

This template is modelled **1:1 on the reference sample ticket** the team
was given as the gold standard. Every section
below is mandatory and must be filled in the same order and to the same
depth as that ticket. A feature ticket that is missing any of the five body
sections — **Bối cảnh, Luồng nghiệp vụ, Quy tắc dữ liệu, UI — wireframe,
Acceptance criteria** — is not ready to leave Phase 2.

Write the ticket body in **Vietnamese** (same as the reference ticket and
the meeting records). Keep the meta fields and the `<...>` guidance notes as
they are; replace every `<...>` with real content and delete the notes.

---

## Ticket structure (copy the fenced block into Jira)

```
Title: [School name] — [short, action-oriented description of the request]

Component/Label: <business module, e.g. Học bạ, Đơn hàng>
Source: meeting-YYYY-MM-DD-schoolcode
Issue type: Task
Priority: <Highest | High | Medium | Low | Lowest — required; set per the priority rules below>
Priority reason: <one line quoting the cue from the meeting note that justifies the chosen priority, so the BA can review it at the Phase 2 checkpoint>

## Duplicate check
Searched for a pending NEW ticket on this Component/Label before creating
this one.
- [ ] No duplicate found — new ticket created
- [ ] Possible duplicate: <ticket key> — flagged instead of creating a new one

## Bối cảnh
<Why this feature is needed. State the real-world / regulatory context
(e.g. chương trình GDPT 2018), the current behaviour that is wrong or
missing, and the concrete pain it causes. End with one sentence naming what
must be added and why the data it produces matters (e.g. quyết định nội dung
file XML → phải tuyệt đối chính xác). 4–8 câu.>

## Luồng nghiệp vụ
<The end-to-end flow, as a user experiences it. Describe:
- Where the feature is entered from (màn hình nào, ai thao tác — GVCN, ...).
- The layout of each screen (e.g. master–detail: bên trái ... / bên phải ...).
- The main happy-path actions step by step (chọn → tick → Lưu → áp dụng).
- Convenience behaviours (giá trị tick mặc định, nút sao chép cấu hình,
  badge trạng thái, tìm kiếm, chọn cả lớp).
- Multi-select / conflicting-state behaviour (checkbox indeterminate: chỉ
  môn được tick/bỏ tick mới ghi đè, môn giữ indeterminate thì không đổi).
- Downstream effect when the feature's output is consumed (khi tạo học bạ:
  chưa cấu hình → cảnh báo + disable; bản hiển thị và file XML chỉ chứa đúng
  dữ liệu đã cấu hình; panel liên quan chỉ hiện dữ liệu hợp lệ).
Cover the happy path AND the notable edge cases — do not leave behaviour to
the reader's imagination.>

## Quy tắc dữ liệu
<The hard data rules the implementation must obey. Include, where relevant:
- Scope/khoá lưu trữ (lưu theo học sinh + năm học, ...).
- Format & validation of any generated artifact (mã theo danh mục Bộ, đúng
  thứ tự, validate với XSD trước khi lưu/đẩy; fail → chặn và báo rõ trường
  nào; encoding UTF-8; escape ký tự đặc biệt).
- Handling of incomplete data (môn chưa phân công GV: cho lưu nhưng cảnh báo,
  ô ký trống theo schema, không tự sinh giá trị).
- Locking / immutability (đã ký số → read-only, muốn sửa phải thu hồi).
- Auditing (ghi audit log: ai, lúc nào, trước/sau).
Each rule must be testable and phrased as a constraint, not a suggestion.>

## UI — wireframe
<One sub-section per screen. For EACH screen provide:
1. A heading naming the screen and its purpose.
2. A pointer line to the attached mockup image
   (e.g. "Ảnh mockup chi tiết xem file đính kèm mockup-1-<ten-man>.png").
3. An ASCII wireframe inside a fenced/backtick block showing real layout,
   sample rows and key controls.
4. Ghi chú: notes explaining dynamic UI behaviour (màu badge, trạng thái
   mờ/indeterminate, kéo-thả sắp thứ tự, ...).
Attach the referenced mockup PNGs to the Jira ticket. If a mockup does not
exist yet, still draw the ASCII wireframe and mark the image as TODO.>

**Màn 1 — <tên màn hình> (<kiểu bố cục, vd master–detail>).** Ảnh mockup chi tiết xem file đính kèm mockup-1-<ten-man>.png.

`+----------------------------------------------------------------------+`
`| <tiêu đề màn hình> ... <trạng thái/summary>                          |`
`+-------------------+--------------------------------------------------+`
`| <panel trái>      | <panel phải>                                     |`
`| [x] <mục 1>       | [x] <chi tiết / cột phụ>                          |`
`| [ ] <mục 2>       | [ ] <mục mờ>   <ghi chú trạng thái>               |`
`+-------------------+--------------------------------------------------+`
`| [<nút phụ>]                 [Huỷ]  [<nút hành động chính>]           |`
`+----------------------------------------------------------------------+`

Ghi chú: <mô tả badge/màu sắc/indeterminate/kéo-thả và các hành vi động khác>.

**Màn 2 — <tên màn hình> (<điều chỉnh gì>).** Ảnh mockup chi tiết xem file đính kèm mockup-2-<ten-man>.png.

`+----------------+------------------------------------------------------+`
`| <cột điều hướng>| <vùng nội dung chính>                               |`
`|----------------|------------------------------------------------------|`
`| <mục + trạng   | <danh sách / panel phụ thuộc cấu hình>              |`
`|  thái badge>   |                                                      |`
`+----------------+------------------------------------------------------+`

## Acceptance criteria
<Concrete, testable scenarios — one per line, phrased as
"điều kiện → kết quả kiểm chứng được". Use real numbers and specific data
like the reference ticket. Cover at minimum:
- The main happy path with exact expected output (12 môn → XML 12 node, đúng
  mã, đúng thứ tự, validate pass).
- A "hidden / excluded data" case (ẩn 7/19 môn → 7 môn không xuất hiện).
- A bulk / multi-record case (lưu 30 học sinh → cả 30 cập nhật giống nhau).
- The multi-select conflicting case (2 HS lệch 1 môn → indeterminate; không
  đụng thì giữ nguyên khác nhau).
- The blocking / incomplete case (chưa cấu hình → disable nút + thông báo).
- The locked / immutable case (đã ký số → read-only).
- A warning-but-allowed boundary case (13 môn → cảnh báo vàng vẫn lưu, XML
  13 node hợp lệ).>
- <criterion 1>
- <criterion 2>
- <criterion 3>
```

---

## Strict rules for Claude Code

1. **All five body sections are mandatory.** Never emit a feature ticket that
   drops Bối cảnh, Luồng nghiệp vụ, Quy tắc dữ liệu, UI — wireframe, or
   Acceptance criteria. If the meeting note doesn't give enough to fill one,
   write what is known and mark the gap explicitly as
   `<CẦN LÀM RÕ: ...>` — never silently omit the section.
2. **Do not invent business rules.** Bối cảnh, Luồng nghiệp vụ and Quy tắc
   dữ liệu must be grounded in the meeting note. Where the note is silent on
   an edge case (locking, validation, audit), raise it as an open question
   inside the section rather than fabricating a specific rule.
3. **Every screen gets a wireframe.** UI — wireframe must contain at least one
   ASCII wireframe and one `mockup-N-*.png` reference per screen mentioned in
   the flow. Attach the images to the ticket; if an image is missing, keep the
   ASCII wireframe and mark the file as TODO.
4. **Acceptance criteria must be verifiable.** Each line is a concrete
   scenario with expected output (numbers, states, file/XML effects) that QC
   can check pass/fail — not a vague quality statement.
5. **Language: Vietnamese body.** Match the reference ticket and meeting
   records. Only the meta guidance stays in English.
6. **Excluded-scope check first.** If the request touches grading/scoring,
   student personal data, transcripts, or admissions ranking, do not run the
   Automate flow — flag it for the stricter manual-confirmation process and
   stop (per the meeting-note template rules).
7. **Priority is required.** Valid values: **Highest, High, Medium, Low,
   Lowest.** For a Task (feature / enhancement), set priority by how urgently
   the school needs it, judged from the meeting-note content:
   - Urgently needed / near deadline / blocking their work (cues: "urgent",
     "deadline", "before <date>", "currently affected") → **High** or
     **Highest**.
   - Nice-to-have enhancement or future work (cues: "will add to the plan",
     "would like to have later", "someday") → **Low** or **Medium**.
   - Urgency unclear → set **Medium** and add the note
     "priority needs BA confirmation"; do NOT guess high or low.
   Always fill the `Priority reason:` line with a one-line justification that
   quotes the cue from the meeting note, so the BA can review it quickly at the
   Phase 2 checkpoint.

**BA checkpoint:** this ticket sits in the summary table AI produces at the
end of Phase 2 (new tickets / duplicates skipped / bugs linked). The BA
reviews and confirms — including that the five sections are complete and the
mockups are attached — before it moves to In Progress.
