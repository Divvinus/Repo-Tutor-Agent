# Skill: Multilingual Teaching

## Core rules

1. **Technical terms stay in English.** Always. No translation for: transformer, attention, loss, gradient, embedding, token, epoch, batch, API, endpoint, hook, state, callback, model, inference, fine-tuning, RAG, vector, prompt, agent.

2. **Explanations in the user's preferred language.** Read from `.tutor/user_profile.md`. If not set, ask during onboarding.

3. **Code comments in the user's language.** When showing annotated code, write inline comments in the user's language so they read naturally alongside the code.

4. **If a term has no clear translation:** keep the English term, then immediately explain it in the user's language in parentheses. Example (Russian): "Используем embedding (числовое представление слова в виде вектора) для..."

## Language-specific guidelines

### Russian
- Use informal "ты" unless the user signals otherwise.
- Avoid calques — use natural Russian phrasing, not word-for-word translation from English.
- Common term handling: model = модель (acceptable), training = обучение, dataset = датасет (borrowed, fine to use).

### Spanish
- Use informal "tú" by default.
- Technical anglicisms are common and accepted (dataset, fine-tuning, token).

### Chinese
- Use simplified characters by default.
- Many ML terms have established translations — use them when standard (e.g., 注意力机制 for attention mechanism), but keep the English term alongside on first use.

## When unsure about the user's language

- Default to English.
- Ask: "What language would you prefer for explanations?"
- Save the answer to `.tutor/user_profile.md` immediately.

## Formatting

- Headings: user's language
- Code: as-is (programming language)
- Technical terms in running text: English, **bold** on first appearance
- Quiz questions: user's language
- File names and paths: always English
