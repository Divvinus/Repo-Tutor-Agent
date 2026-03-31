# Agent Registry

Centralized registry of all system agents. Every agent, tool, and skill is registered here.
Lookup is case-insensitive. This is the single source of truth for routing.

## Agents

| Agent | Type | Triggers | Priority | Receives-context-from | Returns-to | Required-context | Optional-context |
|---|---|---|---|---|---|---|---|
| session-manager | lifecycle | session start/end/switch | 0 (system) | system | system | user_profile path + repo folder path | — |
| onboarding | one-time | missing/empty user_profile.md | 0 (system) | system | tutor | — | — |
| repo-analyzer | one-time | `learning <URL>` | 0 (system) | system | tutor | repo_url | — |
| qa-agent | interrupt | any user question (`why`, `what is`, `what does`, `show me`, `where is`, `I don't understand`, `can you explain`, `what if`, `почему`, `что такое`, `покажи`, `не понимаю`, `объясни`) | 1 (highest) | tutor / quiz-master / architect | caller | current_concept + concept_index + phase | user_question |
| architect | auto-chain | auto after quiz PASS | 2 | tutor | tutor | concept_name + concept_index + learning_path + repo_summary_path | repo_summary |
| deep-dive | on-demand | `go deeper`, `show internals`, `how does this really work`, `глубже`, `под капотом`, `как это реально работает` | 2 | tutor | tutor | current_concept + file_refs | git_history |
| quiz-master | sequential | after tutor explains concept | 3 | tutor | tutor | concept_name + user_level | previous_attempts |
| difficulty-adjuster | escalation | after 2 quiz failures | 3 | tutor | tutor | concept_name + failed_attempts + user_said | blockers_history |
| tutor | core-loop | after onboarding / session-resume | 3 | session-manager / onboarding | session-manager | learning_path + progress + user_profile | session_summary |
| repo-comparator | standalone | `compare with similar`, `show alternatives`, `other repos`, `сравни с похожими`, `похожие репозитории` | 3 | tutor | tutor | current_repo + learning_path | user_profile |
| context-summarizer | terminal | session end keywords (`stop`, `bye`, `quit`, `стоп`, `хватит`, `пока`, `basta`, `adiós`, `停`, `再见`) | 4 | session-manager | session-manager | all .tutor/ files for current repo | — |
| deep-repo-analyzer | parallel-worker | launched by repo-comparator x3 | 4 | repo-comparator | comparison-aggregator | target_repo_url + current_repo_context + learning_path_ref | user_profile |
| comparison-aggregator | assembler | after 3 deep-repo-analyzers complete | 4 | deep-repo-analyzer x3 | tutor | 3 analysis results + current repo | learning_path |

## Routing Rules

1. **Priority 0 (system)** — agents launched automatically by the system
2. **Priority 1 (interrupt)** — interrupts any running agent, returns control after answering
3. **Priority 2 (auto-chain)** — launched automatically after a specific event
4. **Priority 3 (sequential)** — part of the main learning flow
5. **Priority 4 (terminal/worker)** — service agents, no direct user interaction

## Lookup Rules

- Case-insensitive name matching
- Trigger matching: check user phrases against the Triggers column
- On conflict: the agent with the lower Priority number wins (higher priority)
- qa-agent ALWAYS has the right to interrupt any agent
