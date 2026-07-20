# AI Note-Review Checklist (pre-ticket, Simplify)

This runs **after** the BA has already done the elicitation work — met the
school, asked their own questions, and written the note. AI does **not**
help run the meeting or generate questions to ask the school. Its only job
here is to act as a second pair of eyes on the finished note: read it,
point out anything that looks unclear or risky, and let the BA decide what
to do about it.

This is a **Simplify** step: AI assists, the BA leads and makes every call.

## Where this sits in the flow

```
BA meets school, clarifies, writes note   (BA alone — no AI)
        ↓
AI reviews the note against this checklist  ← this file
        ↓
BA reads AI's suggestions, then decides:
   • suggestions look useful  → go back to the school for more detail
   • note is already fine     → skip, proceed
        ↓
AI writes the standard meeting record / creates tickets  (Automate)
```

## Hard rules for Claude Code

1. **Suggest only — never decide, never edit the note.** Output is a list of
   observations for the BA to consider. Do not rewrite the note, do not
   create tickets, do not contact anyone.
2. **If the note is already clear, say so plainly.** A clean "No blocking
   issues — ready to proceed to ticket creation" is a valid and expected
   result. Do not invent problems to look useful.
3. **Never assume intent.** If something is ambiguous, flag it as a question
   for the BA, do not fill in a guess and proceed.
4. **This step is optional for the BA to act on.** The BA may read the
   suggestions and choose to skip all of them. That is their call, not a
   failure of the review.
5. **Keep it short.** Group observations by the item they refer to; one or
   two lines each. No long essays.

## What AI checks (the review criteria)

For each item in the note, AI checks:

**A. Goal vs. solution**
Is the *goal* clear (what the school is trying to achieve), or does the note
only capture a *solution* they proposed? A note that says "add a button
here" without saying *why* is a flag — the underlying goal may be solvable
a better way. Flag as: "Item X states a solution but not the goal — worth
confirming what they're trying to achieve."

**B. State / flow completeness** (for anything with multiple steps)
For features that involve a record moving through stages (e.g. an
application/order that gets submitted, reviewed, approved), does the note
say what the states are and who changes them? Missing states are the most
common gap. Flag as: "Item X doesn't specify the statuses / who can change
them."

**C. Contradictions or duplicates**
Do any two items conflict, or describe the same thing twice? Flag both and
let the BA reconcile.

**D. Excluded-scope check** (do this first, always)
Does the item touch grading/scoring, student personal data, transcripts,
attendance-for-compliance, or admissions ranking? If yes, flag it clearly:
"Item X is in excluded scope — route to the stricter manual-confirmation
process, not the automated ticket flow." Do not classify or ticket it.

**E. Enough to create a ticket?**
Is there enough detail to fill the required fields in the ticket templates
(`feature-ticket-template.md` / `bug-ticket-template.md`) — Component,
priority signal, acceptance-criteria basis? If a required field can't be
derived, name the specific missing piece rather than a vague "needs more
detail."

**F. Classification confidence** (light touch)
Would this item be easy to classify as Feature vs. Bug using the cues in
`ba-meeting-note-template.md`, or is it genuinely ambiguous? Only flag the
genuinely ambiguous ones — don't narrate the obvious ones.

## Output format AI should use

```
## Note review — <school>, <date>

**Excluded-scope items (route to manual process):**
- <item> — <why>
  (or: "None.")

**Suggestions to consider (optional — your call):**
- Item <n> — <one-line observation + the question to ask the school>
  (or: "None — items are clear.")

**Ready to proceed?**
<Yes, ready for ticket creation> OR <Recommend clarifying the items above first>
```

## What this file is NOT

- Not a script of questions to ask the school (the BA runs elicitation).
- Not a gate that blocks the BA — they can proceed over any suggestion.
- Not a place where AI creates or edits anything — that happens in the
  Automate phase, only after the BA has finalized the note.
