# Repo Tutor Agent

**Drop a GitHub repo link. Learn it completely.**

An AI tutor that breaks down any AI/ML GitHub repository into digestible concepts and teaches them to you one by one — at your pace, in your language, with real code references. No more skimming READMEs and hoping for the best.

## Who is this for?

Developers entering the AI tools ecosystem who want to deeply understand repos rather than just copy-paste from them. Whether you're exploring your first MCP server or diving into a multi-agent framework, this agent meets you where you are.

## How to use

1. Install the [Claude Code extension](https://marketplace.visualstudio.com/items?itemName=anthropics.claude-code) in VS Code
2. Clone this repo or copy `CLAUDE.md` into your project root
3. Open Claude Code and type:
   ```
   learning https://github.com/owner/repo
   ```
4. The agent handles everything else

## What happens during a session

- The repo is analyzed and broken into an ordered concept map
- You're asked about your experience level and preferred language
- Concepts are presented one at a time, analogy first, then code
- A quick question checks your understanding before moving on
- If something doesn't click, the explanation adapts automatically
- Progress is saved so you can pick up exactly where you left off

## State files

The agent stores session state in a `.tutor/` directory:

```
.tutor/
├── user_profile.md                          # GLOBAL — shared across all repos
└── repos/
    └── {owner}--{repo-name}/                # One folder per repo
        ├── learning_path.md                 # Full concept breakdown
        ├── progress.md                      # Where you are in the learning path
        ├── blockers.md                      # Concepts you struggled with
        ├── quiz_results.md                  # Quiz attempt history
        ├── repo_summary.md                  # User-friendly concept summaries
        ├── session_summary.md               # Summary of last session for resumption
        └── session_log.md                   # Session history table
```

| File | Location | Purpose |
|---|---|---|
| `user_profile.md` | `.tutor/` (global) | Your language, level, and known concepts — shared across all repos |
| `learning_path.md` | `.tutor/repos/{owner}--{repo}/` | Full concept breakdown of this repo |
| `progress.md` | `.tutor/repos/{owner}--{repo}/` | Where you are in the learning path |
| `session_summary.md` | `.tutor/repos/{owner}--{repo}/` | Summary of your last session for seamless resumption |
| `blockers.md` | `.tutor/repos/{owner}--{repo}/` | Concepts you struggled with |
| `quiz_results.md` | `.tutor/repos/{owner}--{repo}/` | Quiz attempt history |
| `repo_summary.md` | `.tutor/repos/{owner}--{repo}/` | User-friendly concept summaries |
| `session_log.md` | `.tutor/repos/{owner}--{repo}/` | Session history table |

## Great repos to try this with

- [awesome-claude-code](https://github.com/anthropics/awesome-claude-code) — curated tools and extensions
- Cursor rules collections — prompt engineering patterns
- MCP server repos — tool-use and server architecture
- [LangGraph](https://github.com/langchain-ai/langgraph) / [CrewAI](https://github.com/crewAIInc/crewAI) — multi-agent frameworks
- Token-saving utilities — context window optimization tricks

## Contributing

Found a bug or have an idea? Open an issue or submit a PR. Keep changes focused and well-described.

## License

MIT
