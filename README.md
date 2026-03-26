<div align="center">

# 🎓 Repo Tutor Agent

**Drop a GitHub repo link. Understand it completely.**

An AI-powered tutor built on Claude Code that teaches you any AI/ML repository — concept by concept, in your language, at your pace. No more skimming READMEs and hoping for the best.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status: Beta](https://img.shields.io/badge/Status-Beta-orange)](https://github.com)

[Getting Started](#-getting-started) · [How It Works](#-how-it-works) · [Features](#-features) · [Architecture](#-architecture) · [Contributing](#-contributing)

---

[![Telegram](https://img.shields.io/badge/Telegram-@divinus__ai-2CA5E0?logo=telegram&logoColor=white)](https://t.me/divinus_ai)
[![YouTube](https://img.shields.io/badge/YouTube-@divinus__ai-FF0000?logo=youtube&logoColor=white)](https://www.youtube.com/@divinus_ai)
[![X](https://img.shields.io/badge/X-@divvinus-000000?logo=x&logoColor=white)](https://x.com/divvinus)

</div>

---

## 🧠 What Is This?

**Repo Tutor Agent** is a Claude Code agent that acts as your personal AI tutor for any AI/ML GitHub repository.

You paste a link. The agent reads the entire repo, builds a personalized learning path, and walks you through it one concept at a time — asking questions to make sure you actually understand before moving on.

It's not a chatbot. It's a structured learning system that:
- Adapts to your **experience level** (beginner / intermediate / advanced)
- Teaches in your **native language** (Russian, Spanish, Chinese, any language)
- **Saves your progress** between sessions so you never lose your place
- Tracks what you **struggle with** and adjusts automatically

> Built for developers entering the AI tools ecosystem who want to *understand* repos — not just copy-paste from them.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔍 **Auto Repo Analysis** | Reads README, structure, and key files to build an ordered learning path |
| 🗺️ **Concept Map** | Breaks any repo into 5–7 modules, prerequisites first |
| 🌍 **Multilingual** | Explains in your language, keeps technical terms in English |
| 🎯 **Adaptive Level** | Beginner gets analogies. Advanced gets tradeoffs and edge cases |
| ❓ **Understanding Checks** | Asks one question per concept. Won't move on until you get it |
| 🔄 **Difficulty Adjuster** | 5 different strategies to re-explain when something doesn't click |
| 💬 **Live Q&A** | Ask anything mid-session — the tutor answers and resumes where you left off |
| 💾 **Session Memory** | Full progress saved per-repo. Pick up exactly where you left off |
| 📊 **Progress Tracking** | % complete, blockers, quiz history, session log — all in plain markdown |
| 🔀 **Multi-Repo** | Study multiple repos simultaneously, each with its own progress folder |

---

## 🚀 Getting Started

### Prerequisites

- [Claude Code](https://claude.ai/code) installed (VS Code extension or CLI)
- A Claude account (Pro or above recommended)

### Installation

```bash
# Clone the repo
git clone https://github.com/your-username/repo-tutor-agent
cd repo-tutor-agent
```

That's it. No dependencies. No npm install. No config files.

### Usage

Open Claude Code in the project directory and type:

```
learning https://github.com/owner/repo
```

The agent does everything else.

---

## 🎬 What Happens During a Session

```
You: learning https://github.com/rtk-ai/rtk

Agent: [analyzes repo structure and key files]
       [creates a 7-module learning path]

       RTK is a CLI tool that reduces token consumption by 60-90%
       when working with AI coding assistants. ~90 min to learn fully.

       What language should I explain things in?

You: English

Agent: Got it! How would you rate your experience level?
       (beginner / intermediate / advanced)

You: intermediate

Agent: Got it. Let's start with Module 1 — What RTK Does and Why It Exists.

       [explains concept with real-world analogy]
       [references specific files with line numbers]

       Does this make sense so far? Quick question to check:
       In what scenario would rtk replace a standard `cat` command?

You: When you want to read a file but filter out noise for the AI context?

Agent: ✅ Exactly right. Progress: 1/7 concepts (14%)
       Moving to Module 2 — The 6-Phase Command Lifecycle...

You: stop

Agent: [saves all progress to .tutor/repos/rtk-ai--rtk/]

       🎯 Session 1 complete
       ⏱️ Time: ~23 minutes
       ✅ Learned: Purpose & motivation, Command lifecycle
       📈 Progress: 2/7 concepts (28%)
       👉 Next time: We'll look at src/filter.rs and the 12 compression strategies
```

---

## 🗂️ How Progress Is Stored

All state is saved in plain markdown files — human-readable, version-controllable, no database needed.

```
.tutor/
├── user_profile.md              ← your language, level, style (global, set once)
└── repos/
    ├── rtk-ai--rtk/
    │   ├── learning_path.md     ← generated concept map for this repo
    │   ├── progress.md          ← what you've completed, current position
    │   ├── blockers.md          ← concepts that gave you trouble
    │   ├── quiz_results.md      ← full quiz history
    │   ├── repo_summary.md      ← your understanding in your own words
    │   ├── session_summary.md   ← last session recap for resumption
    │   └── session_log.md       ← all sessions history
    └── anthropics--claude-code/
        └── ...                  ← separate progress for each repo
```

> **Your profile is set once** and shared across all repos. Switching repos doesn't reset your language or level.

---

## 🏗️ Architecture

The agent is built as a multi-agent system:

```
CLAUDE.md (orchestrator)
│
├── agent: repo-analyzer      — reads repo, builds learning_path.md
├── agent: onboarding         — collects user profile (runs once ever)
├── agent: tutor              — delivers step-by-step explanations
├── agent: quiz-master        — verifies understanding after each concept
├── agent: difficulty-adjuster — re-explains when quiz fails (5 strategies)
├── agent: qa-agent           — handles spontaneous questions mid-session
├── agent: context-summarizer — saves all state at session end
└── agent: session-manager    — handles resumption, switching, timeouts

hooks/
└── stop.sh                   — auto-saves progress on session end

skills/
├── skill-read-repo           — how to navigate a repo efficiently
├── skill-explain-by-level    — adapts depth to beginner/intermediate/advanced
├── skill-create-analogy      — generates non-tech analogies for any concept
├── skill-generate-quiz       — creates understanding-based questions (not recall)
├── skill-multilingual        — keeps technical terms EN, explanations in user lang
├── skill-track-metrics       — calculates and displays progress stats
└── skill-write-progress      — standardized format for all progress files
```

---

## 🔥 Great Repos To Learn With

| Repo | What You'll Learn |
|---|---|
| [rtk-ai/rtk](https://github.com/rtk-ai/rtk) | Token optimization, CLI proxy patterns, Rust architecture |
| [anthropics/claude-code](https://github.com/anthropics/claude-code) | Agent harnesses, hooks, skills, subagents |
| [langchain-ai/langgraph](https://github.com/langchain-ai/langgraph) | Graph-based agent orchestration |
| [crewAIInc/crewAI](https://github.com/crewAIInc/crewAI) | Multi-agent collaboration patterns |
| [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | Subagent design patterns |
| Any `.cursorrules` collection | Prompt engineering for AI editors |
| Any MCP server repo | Tool-use and server architecture |

---

## 💡 Tips

**Resume a session:**
```
learning https://github.com/owner/repo
```
The agent detects your existing progress and picks up where you left off.

**Switch to a different repo:**
```
learning https://github.com/other-owner/other-repo
```
Current progress is saved automatically. Come back to the first repo anytime.

**Ask questions mid-session:**
```
Why is this function using lazy_static here?
Show me where this pattern is used in the codebase
What would happen if I removed this filter?
```
The tutor pauses, answers, then resumes exactly where you left off.

**End a session:**
```
stop / bye / стоп / hasta mañana / 再见
```
All progress is saved before the agent says goodbye.

---

## 🤝 Contributing

Contributions welcome. Keep them focused:

- **New skills** — add to `.claude/skills/` following the existing format
- **New analogy examples** — extend `skill-create-analogy.md`
- **Bug reports** — open an issue with the repo URL that triggered it
- **Language improvements** — PRs for multilingual edge cases appreciated

Please test any changes with at least one real repo before submitting.

---

## 📄 License

MIT — do whatever you want with it.

---

<div align="center">

Made for developers who want to actually understand what they're using

**Author:** [@divinus_py](https://t.me/divinus_py) · [@divinus_ai](https://t.me/divinus_ai) · [@divvinus](https://x.com/divvinus) · [YouTube](https://www.youtube.com/@divinus_ai)

</div>