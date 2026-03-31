# Permission Policy

Trust-based gating system for Repo Tutor agents. Three permission levels control all destructive and sensitive operations.

---

## Permission Levels

### ALLOW (automatically permitted)

- Reading any files from `.tutor/`
- Reading files of the studied repository
- WebSearch and WebFetch for repository information lookup
- Writing to existing files in `.tutor/repos/{repo}/` (append-only operations)

### CONFIRM (requires user confirmation)

- Cloning a new repository (repo-analyzer)
- Creating a new folder `.tutor/repos/{new-repo}/` (first time for a new repo)
- Full overwrite of `user_profile.md` (not append — complete rewrite)
- Deleting any files from `.tutor/`
- Switching between repositories mid-session (session-manager)

### DENY (always forbidden)

- Deleting the `.tutor/` folder entirely
- Modifying files of the studied repository (we only read external code)
- Writing files outside `.tutor/` and `.claude/` directories
- Running arbitrary Bash commands unrelated to `git clone` / `git log`

---

## Agent-Specific Permissions

| Agent | ALLOW | CONFIRM | DENY |
|-------|-------|---------|------|
| repo-analyzer | read repo, write learning_path.md | git clone, create repo folder | modify source repo |
| onboarding | read .tutor/ | create user_profile.md | overwrite existing profile |
| tutor | read all .tutor/, write progress.md | — | write outside .tutor/ |
| quiz-master | read profile + path, write quiz_results.md | — | modify progress directly |
| architect | read repo + summary, append repo_summary.md | — | modify learning_path |
| context-summarizer | read all .tutor/, write session files | overwrite session_summary.md | delete any files |
| session-manager | read all .tutor/ | switch repo, auto-save on timeout | delete repo folders |
| difficulty-adjuster | read profile + blockers, write blockers.md | — | modify quiz_results |
| qa-agent | read everything | — | write outside .tutor/ |
| deep-dive | read repo + .tutor/ | — | modify source repo |
| repo-comparator | read .tutor/, WebSearch | clone comparison repos | modify current repo state |
| deep-repo-analyzer | read target repo, WebFetch | — | write to current repo .tutor/ |
| comparison-aggregator | read analysis results, write repo_summary | — | modify learning_path |

---

## Enforcement Rules

1. Before ANY write to a file — the agent MUST first read the current contents.
2. Append-only files (`progress.md`, `blockers.md`, `quiz_results.md`, `session_log.md`) — NEVER overwrite entirely, only append.
3. `session_summary.md` — the only file that gets overwritten (not append), but CONFIRM on first creation.
4. When permissions conflict — DENY wins.