# Session Hooks — Repo Tutor Agent

This document defines all event-driven hooks used by the Repo Tutor system. Each hook specifies when it fires, what actions it performs (in order), and which agent is responsible.

---

## 1. on-session-start

**Trigger condition:** User begins a new conversation or sends their first message in a session.

**Actions (in order):**

1. Check if `.tutor/` directory exists.
2. Load `.tutor/user_profile.md` (GLOBAL) — read language, experience level, learning style.
3. Determine the active repo folder: `.tutor/repos/{owner}--{repo-name}/`.
4. Load `.tutor/repos/{owner}--{repo-name}/progress.md` — read completed concepts, current position.
5. Load `.tutor/repos/{owner}--{repo-name}/blockers.md` — check for any open or deferred blockers from previous sessions.
6. Load `.tutor/repos/{owner}--{repo-name}/session_summary.md` — read last session's summary.
7. If returning user: display a recap message including:
   - What was covered last time (from `session_summary.md`)
   - Where they left off (from `progress.md`)
   - Any unresolved blockers (from `blockers.md`)
   - The next concept in the learning path
8. If new user (no `.tutor/user_profile.md` found): do nothing here — `on-new-repo` will handle onboarding.

**Handled by:** Main tutor agent (orchestrator).

---

## 2. on-session-end

**Trigger condition:** User sends any session-end phrase (e.g., `stop`, `bye`, `quit`, `пока`, `basta`, `再见` — full list in CLAUDE.md).

**Actions (in order):**

1. Immediately halt current explanation or quiz flow.
2. Trigger the **context-summarizer agent** to generate a summary of:
   - Concepts covered this session
   - Concepts the user struggled with
   - Current position in the learning path
   - Any open blockers
3. Save `session_summary.md` to `.tutor/repos/{owner}--{repo-name}/`.
4. Update `.tutor/repos/{owner}--{repo-name}/progress.md` with the latest completed concept and position.
5. Update `.tutor/repos/{owner}--{repo-name}/blockers.md` — ensure all blocker statuses are current.
6. Display session recap to the user:
   - Number of concepts covered
   - Current overall progress percentage
   - One concrete next step (something to read, think about, or try before next session)
7. Say goodbye in the user's preferred language.

**Handled by:** Context-summarizer agent, with final output from main tutor agent.

---

## 3. on-new-repo

**Trigger condition:** User sends `learning <URL>`, `learn <URL>`, or `explain this repo <URL>` with a GitHub repository URL.

**Actions (in order):**

1. Check if `.tutor/` directory exists. If not, create it.
2. Check if `.tutor/user_profile.md` exists. If not, create it as an empty file (onboarding will fill it in).
3. Parse `{owner}` and `{repo-name}` from the URL. Create `.tutor/repos/{owner}--{repo-name}/` folder with empty files:
   - `learning_path.md`
   - `progress.md`
   - `session_summary.md`
   - `blockers.md`
   - `quiz_results.md`
   - `repo_summary.md`
   - `session_log.md`
4. Trigger the **repo-analyzer agent**:
   - Clone or fetch the repo structure
   - Identify: purpose, architecture, key concepts, dependencies
   - Build an ordered concept map (prerequisites first)
   - Save the result to `.tutor/repos/{owner}--{repo-name}/learning_path.md`
5. Check if `.tutor/user_profile.md` has content.
   - If empty or missing (new user): trigger the **onboarding agent**:
     - Ask preferred language
     - Ask experience level (beginner / intermediate / advanced)
     - Ask familiarity with key AI/ML concepts found in this repo
     - Save profile to `.tutor/user_profile.md` (GLOBAL — never per-repo)
   - If populated (returning user): greet by context, confirm they want to start a new repo.
6. Initialize `.tutor/repos/{owner}--{repo-name}/progress.md` with the new repo URL, total concept count, and position set to concept 1.
5. Begin the learning flow with the first concept from the concept map.

**Handled by:** Repo-analyzer agent (step 2), onboarding agent (step 3 if new user), main tutor agent (orchestration).

---

## 4. on-confusion-detected

**Trigger condition:** Any of the following signals are observed during an explanation or quiz:

- Very short replies after an explanation: "ok", "sure", "yes", "uh huh" (likely not processing)
- Contradictory replies that conflict with what was just explained
- Repeated questions — user asks the same thing again, possibly rephrased
- Explicit confusion: "wait", "I'm lost", "don't get it", "huh?", "что?", "не понял", "no entiendo"
- Quiz answer is partially correct but reveals a fundamental misunderstanding

**Actions (in order):**

1. Immediately stop the current explanation. Do not continue forward.
2. Ask the user directly: "What part feels unclear?" or "Can you point to the specific idea that's confusing?"
3. Record the blocker in `.tutor/repos/{owner}--{repo-name}/blockers.md`:
   - Concept name
   - Date
   - Status: `open`
   - What the user said or answered
4. Try up to 3 different explanation strategies (in order):
   - **Strategy A — New analogy:** Explain using a completely different real-world analogy (non-tech).
   - **Strategy B — Break it down:** Decompose into 2-4 sub-concepts, explain each separately, then reconnect.
   - **Strategy C — Minimal example:** Show the smallest working code snippet (under 15 lines) from the repo that demonstrates the concept, annotated line by line.
5. After each strategy, ask one short verification question.
6. If any strategy succeeds: update blocker status to `resolved`, resume the learning flow.
7. If all 3 strategies fail: trigger the **difficulty-adjuster agent** for deeper intervention.

**Handled by:** Main tutor agent (detection and initial strategies), difficulty-adjuster agent (if escalated after 3 failures).

---

## 5. on-quiz-passed

**Trigger condition:** User correctly answers the verification question for the current concept.

**Actions (in order):**

1. Record completion in `.tutor/repos/{owner}--{repo-name}/progress.md`:
   - Mark the concept as `completed`
   - Record the date
   - Increment the completed concept count
2. Update learning metrics:
   - Track consecutive passes (streak)
   - Track total pass/fail ratio
3. Calculate current progress percentage: `(completed / total concepts) * 100`.
4. Every 3 consecutive passes, display an overall progress update:
   - Current progress percentage
   - Number of concepts remaining
   - Brief encouragement in the user's language
5. Check if the completed concept triggers a milestone (25%, 50%, 75%, 100%) — if so, defer to `on-milestone`. Save the milestone event to `.tutor/repos/{owner}--{repo-name}/progress.md`.
6. Advance to the next concept in the concept map.
7. If no blockers exist for the next concept, begin presenting it immediately.

**Handled by:** Quiz-master agent (verification), main tutor agent (progress tracking and flow control).

---

## 6. on-quiz-failed

**Trigger condition:** User answers the verification question incorrectly.

**Actions (in order):**

1. Record the failure in `.tutor/repos/{owner}--{repo-name}/blockers.md`:
   - Concept name
   - Date
   - Status: `open`
   - The user's incorrect answer
   - The expected answer (for internal tracking only — never shown to user)
2. Increment the fail counter for this concept (tracked in session state).
3. **First failure:**
   - Give a supportive hint that points toward the correct answer without revealing it.
   - Ask a simpler version of the question (narrower scope, more concrete).
4. **Second failure:**
   - Give a more direct hint.
   - Ask an even simpler version — yes/no or multiple choice if appropriate.
5. **After 2 consecutive failures on the same concept:**
   - Trigger the **difficulty-adjuster agent**.
   - The difficulty-adjuster takes full control of the concept until resolved or deferred.
6. Do not advance to the next concept until the current one is resolved, deferred, or skipped.

**Handled by:** Quiz-master agent (asking and evaluating), difficulty-adjuster agent (after 2 failures).

---

## 7. on-milestone

**Trigger condition:** User's completed concept count reaches 25%, 50%, 75%, or 100% of the total concepts in the concept map.

**Actions (in order):**

1. Display a motivating milestone message in the user's language:
   - **25%:** "You've completed a quarter of the concepts — solid foundation being built!"
   - **50%:** "Halfway there — you now understand the core of this repo."
   - **75%:** "Three quarters done — you're in the advanced territory now."
   - **100%:** "You've covered every concept in this repo!"
2. Show a brief stats summary:
   - Concepts completed vs. total
   - Number of blockers encountered and resolved
   - Average attempts per concept
3. **At 100% completion only:**
   - Run a full repo comprehension quiz (5-10 questions covering the most important concepts).
   - Questions should span the entire concept map, weighted toward concepts the user previously struggled with.
   - After the quiz, provide a final assessment and suggest next steps (related repos, deeper topics, practical projects).
4. Save the milestone event to `.tutor/repos/{owner}--{repo-name}/progress.md`.

**Handled by:** Main tutor agent (milestone detection and messaging), quiz-master agent (100% final quiz).

---

## 8. on-level-change

**Trigger condition:** Either of the following occurs:

- **Explicit request:** User asks to change difficulty (e.g., "this is too easy", "can we go deeper", "slow down", "это слишком сложно").
- **Agent detection:** The system detects a persistent mismatch between the user's profile level and their actual performance:
  - 5+ consecutive passes with no confusion signals → user may be above their stated level.
  - 3+ blockers in the last 5 concepts → user may be below their stated level.

**Actions (in order):**

1. Acknowledge the level change to the user. If agent-detected, ask for confirmation: "It seems like this level might be [too easy / too challenging]. Would you like to adjust?"
2. Update `.tutor/user_profile.md` (GLOBAL):
   - Change the `experience_level` field to the new level.
   - Log the change with date and reason (explicit request or detected mismatch).
3. Adapt the remaining modules in the concept map:
   - **Level up (e.g., beginner → intermediate):** Skip concepts already mastered, reduce analogy depth, increase technical detail, introduce more code-level explanations.
   - **Level down (e.g., intermediate → beginner):** Add more analogies, break concepts into smaller pieces, slow the pacing, add more verification checkpoints.
4. Update `.tutor/repos/{owner}--{repo-name}/progress.md` to reflect any skipped or restructured concepts.
5. Resume the learning flow from the current concept, now presented at the new level.

**Handled by:** Main tutor agent (detection and profile update), difficulty-adjuster agent (adaptation of explanation depth).