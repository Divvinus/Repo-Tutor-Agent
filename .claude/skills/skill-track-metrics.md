# Skill: Track Learning Metrics

## Metrics to track

| Metric | How to calculate | Where stored |
|---|---|---|
| % complete | (completed concepts / total concepts) * 100 | `progress.md` |
| Concepts learned | Count of `[x]` items in progress.md | `progress.md` |
| Blockers count | Count of Active items in blockers.md | `blockers.md` |
| Sessions count | Count of `## Session` headings in session_log.md | `session_log.md` |
| Quiz pass rate | passes / (passes + fails) across all sessions | `session_log.md` |
| Current streak | Consecutive concepts passed on first try | `session_log.md` |

## When to display metrics

- **Session start:** Show quick summary — % complete, concepts remaining, any active blockers.
- **After each concept passed:** Update and show new % complete. Keep it brief: "Progress: 5/12 (42%)".
- **Session end:** Full metrics summary in the session log entry.
- **On user request:** Show all metrics in a formatted table when the user asks "how am I doing?" or similar.

## Display format

### Quick update (after each concept)
```
Progress: 5/12 concepts (42%) | Blockers: 1 | Streak: 3
```

### Session summary (at session end)
```
## Session Summary
- Concepts covered: 2 (Attention, Multi-Head Attention)
- Quiz results: 2/2 passed (1 on retry)
- Overall progress: 7/12 (58%)
- Active blockers: 1
- Total sessions: 4
- Next: Positional Encoding
```

## Calculation rules

- Only count a concept as complete when the quiz is passed.
- Bookmarked/skipped concepts count toward total but not toward completed.
- A retry that eventually passes counts as 1 pass and 1 fail for pass rate calculation.
- Streak resets on any first-attempt fail.
