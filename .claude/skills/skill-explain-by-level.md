# Skill: Explain by Experience Level

## Beginner

- **Start with a real-world analogy** before any code or technical terms.
- **Define every term** the first time it appears. Assume nothing.
- Use short sentences. One idea per paragraph.
- Show the simplest possible code snippet (3–5 lines). Highlight what each line does.
- Avoid jargon chains (don't explain one term using three other unknown terms).
- Ask: "Does this make sense so far?" before moving on.
- Reference specific file + line number so the user can look at real code.

## Intermediate

- **Focus on "why"** — why this approach, why this library, why this architecture.
- Compare to alternatives the user likely knows (e.g., "This is like X but with Y difference").
- Explain design decisions and tradeoffs, not just mechanics.
- Show medium-sized code blocks (10–20 lines) with annotations on the non-obvious parts.
- Skip basic definitions unless the concept is domain-specific.
- Encourage the user to predict what happens before revealing the answer.

## Advanced

- **Lead with implementation details** — data structures, algorithms, performance characteristics.
- Discuss tradeoffs: memory vs. speed, accuracy vs. latency, simplicity vs. flexibility.
- Point out edge cases, failure modes, and known limitations.
- Reference papers, specs, or upstream issues where relevant.
- Show full code paths, not just snippets — how modules connect end-to-end.
- Invite critique: "What would you change here?"

## Level detection

If no profile exists yet, infer from the user's language:
- Uses "what is X?" → likely beginner
- Uses "why did they use X instead of Y?" → likely intermediate
- Uses "how does X handle Y edge case?" → likely advanced

Always be ready to shift levels mid-session if the user signals confusion or boredom.
