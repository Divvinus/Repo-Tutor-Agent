# Skill: Write Progress Files

The user profile lives at `.tutor/user_profile.md` (global, shared across all repos).
All other progress files live in `.tutor/repos/{owner}--{repo-name}/` (one folder per repo).

---

## progress.md

```markdown
# Learning Progress

**Repo:** [repo name](URL)
**Started:** YYYY-MM-DD
**Last session:** YYYY-MM-DD
**Overall:** X / Y concepts (Z%)

## Completed

- [x] Concept Name — YYYY-MM-DD
- [x] Concept Name — YYYY-MM-DD

## Current

- [ ] Concept Name (in progress)

## Remaining

- [ ] Concept Name
- [ ] Concept Name

## Bookmarked (skipped, revisit later)

- [ ] Concept Name — reason for skip
```

---

## blockers.md

```markdown
# Blockers & Struggles

## Active

- **Concept Name** — what the user struggled with, date first encountered
  - Attempted explanations: list of approaches tried
  - Status: retry / bookmarked / resolved

## Resolved

- **Concept Name** — what worked, date resolved
```

---

## session_log.md

```markdown
# Session Log

## Session N — YYYY-MM-DD

- **Duration:** ~Xm
- **Concepts covered:** Concept A, Concept B
- **Quiz results:** Concept A (pass), Concept B (fail → retry → pass)
- **Blockers:** none / [list]
- **Next step:** [one concrete action]
```

---

## Emoji markers

Use these consistently across all files:

| Marker | Meaning |
|---|---|
| `[x]` | Completed |
| `[ ]` | Not started |
| `->` | Currently active |

---

## Update rules

- Update `.tutor/repos/{owner}--{repo-name}/progress.md` after every passed quiz.
- Update `.tutor/repos/{owner}--{repo-name}/blockers.md` on every fail (second attempt).
- Append to `.tutor/repos/{owner}--{repo-name}/session_log.md` at session end.
- Never delete history — only append or change status.
- Never touch `.tutor/user_profile.md` from progress writes — it's managed by onboarding only.
