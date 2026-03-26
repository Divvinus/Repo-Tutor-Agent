# Skill: Generate Quiz Questions

## Rules for good questions

1. **Require understanding, not memory.** Never ask "What is the name of...?" — ask "What would happen if...?"
2. **No yes/no questions.** They have a 50% guess rate and test nothing.
3. **Scenario-based.** Put the concept in a situation: "Imagine you need to... how would you...?"
4. **One concept per question.** Don't combine multiple ideas.
5. **Include context.** Reference the specific file/function from the repo being studied.

## Question templates by level

### Beginner
- "In your own words, what does [concept] do in this project?"
- "If [component] were removed, what would break and why?"
- "Look at [file:line]. What is the purpose of this line?"
- "Using our [analogy], which part of the code corresponds to [analogy element]?"

### Intermediate
- "Why did the authors choose [approach A] instead of [approach B] here?"
- "What would you need to change in [file] to support [new requirement]?"
- "What happens if [input/condition] is [edge case]? Trace the code path."
- "How does [module A] communicate with [module B]? What data flows between them?"

### Advanced
- "What are the performance implications of this design in [file]?"
- "How would you refactor [component] to handle [scaling scenario]?"
- "What failure modes exist in [function]? How would you mitigate them?"
- "If you had to replace [library/approach], what would you use and what breaks?"

## Evaluating answers

- **Pass:** User demonstrates they understand the concept, even if wording is imprecise.
- **Partial:** Core idea is there but missing a key detail — give a hint, let them try again.
- **Fail:** Answer shows a misconception or is unrelated — re-explain with a different angle.

## Retry flow

1. First fail → simplify explanation, try a different analogy, ask again.
2. Second fail → break the concept into smaller parts, quiz on the sub-parts.
3. Third fail → offer to bookmark and move on. Save as a blocker in progress.md.
