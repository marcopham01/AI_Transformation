# Feature / Story Ticket Template (Feedback branch)

Used when AI classifies a meeting-note item as Feedback/new request
(Sheet "Feedback vs. Bug Detail"). Ticket type: **Feature/Story**.

```
Title: [School name] — [short description of the request]

Component/Label: <business module, e.g. Orders>
Source: meeting-YYYY-MM-DD-schoolcode

## Request (from meeting note)
<what the school asked for, restated clearly>

## Duplicate check
Searched for a pending NEW ticket on this Component/Label before creating
this one.
- [ ] No duplicate found — new ticket created
- [ ] Possible duplicate: <ticket key> — flagged instead of creating a new one

## Suggested scope
<AI's first-pass read on what this would involve — Dev refines during spec>

## Acceptance criteria (draft)
- <criterion 1>
- <criterion 2>
```

**BA checkpoint:** this ticket sits in the summary table AI produces at the
end of Phase 2 (new tickets / duplicates skipped / bugs linked). The BA
reviews and confirms before it moves to In Progress.
