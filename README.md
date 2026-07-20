# AI_Transformation — Create Order / View Order Demo

This repo is the code base for the AI agentic workflow pilot (Phase 0–5 of
`Roadmap_AI_Agentic_Workflow_Demo.xlsx`). Scope is limited to the **Create
order / View order** feature. Payment, scoring, and student-data features are
out of scope and are not built here.

## Stack

| Layer | Tech |
|---|---|
| Frontend | React (JS/TS) |
| Backend | Go |
| Mobile | React Native — planned, not part of this pilot yet |

## Folder structure

```
AI_Transformation/
├── frontend/           # React app
├── backend/            # Go app (API)
├── docs/
│   ├── CONTRIBUTING.md         # coding style + test style conventions
│   └── templates/
│       ├── ba-meeting-note-template.md
│       ├── feature-ticket-template.md
│       └── bug-ticket-template.md
└── README.md
```

`frontend/` and `backend/` are currently empty — conventions are being set
first so Claude Code has a consistent baseline to branch from once the first
Jira ticket comes through Phase 2.

## How this repo is used in the pilot

1. A BA meeting note is drafted from raw notes and stored in Google Drive (Phase 1).
2. AI reads the note, classifies each item as Feedback/New Request or Bug, and
   creates a Jira ticket using the templates in `docs/templates/` (Phase 2).
3. Claude Code picks up tickets assigned to it, branches off `main` using the
   naming convention in `docs/CONTRIBUTING.md`, implements the change in
   `frontend/` and/or `backend/`, writes tests, and opens a PR (Phase 3).
4. An independent AI QC pass adds edge-case tests on staging and reports
   pass/fail on the ticket (Phase 4).
5. Merge to `main` and deploy remain manual until the automatic rollback
   mechanism is verified (Phase 5).

## Branch protection / access note

Claude Code should only be granted read/write access scoped to **this repo**
and the **AIAT Jira project**, not the org-wide GitHub org or other Jira
projects — this pilot intentionally excludes Payment/Grading/student-data
work.
