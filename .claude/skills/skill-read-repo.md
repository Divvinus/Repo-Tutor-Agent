# Skill: Read a Repository

## Order of reading

1. **README.md** — understand purpose, installation, usage
2. **Project structure** — run `ls` or `tree` (depth 2 max), identify framework and layout
3. **Entry point** — find `main.py`, `index.ts`, `app.py`, or equivalent
4. **Config files** — `pyproject.toml`, `package.json`, `Cargo.toml` — dependencies reveal the stack
5. **Core modules** — the `src/`, `lib/`, or `app/` directory — read key files that implement main logic
6. **Tests** — scan test files to understand expected behavior

## What to ignore

Never read or analyze:
- `node_modules/`, `venv/`, `.venv/`, `__pycache__/`
- `dist/`, `build/`, `.next/`, `out/`
- `.git/`
- Lock files: `package-lock.json`, `yarn.lock`, `poetry.lock`, `Cargo.lock`
- Generated files: `.min.js`, `.map`, compiled outputs
- Binary files: images, fonts, `.whl`, `.egg`

## Strategy for large repos (50+ files)

1. **Top-level only first.** List root directory, read README and config.
2. **Identify 3–5 key directories** by name and purpose (e.g., `models/`, `api/`, `training/`).
3. **Read one representative file per directory** — usually the `__init__.py`, `index.ts`, or the file with the most imports.
4. **Build a mental map before going deep.** Map: entry point → core logic → data flow → output.
5. **Never try to read every file.** Focus on what the concept map requires.

## Output

After reading, produce:
- One-sentence repo purpose
- Stack/framework summary
- List of key directories with roles
- Ordered list of core concepts to teach
