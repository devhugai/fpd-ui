---
trigger: always_on
---

# Documentation Style Guide - Flutter Pilot Dev

## General Principles
- **Language:** English (Default) / Spanish (when specified by user context, current context implies Spanish for planning, English for docs is standard practice but user communicated in Spanish. *Decision: Keep Docs in English for International Standard unless local repo requires Spanish. Given Pub.dev target, English is preferred.*)
- **Tone:** Professional, Clear, Concise.

## Naming Conventions
- **Prefix:** `fpdui` should be referenced when discussing package specifics.
- **Paths:** Use relative paths in documentation where possible, or full project paths if referencing specific local setups.

## File Format
- **Markdown:** All documentation must be in `.md` format.
- **Naming:** Filenames MUST use **kebab-case** (hyphens `-`), NOT underscores (`_`).
  - Correct: `style-guide-doc.md`
  - Incorrect: `style_guide_doc.md`
- **Structure:**
  1. Title (H1)
  2. Brief Description
  3. Table of Contents (if long)
  4. Content Sections (H2-H3)

## Typography
- **Keywords:** Use `backticks` for code elements, filenames, directories, and configuration options.
- **Links:** Use descriptive link text. `[Title](url)`.

## Branding
- Reference "Flutter Pilot Dev" full name in introductions.
- Use `fpdui` for the library name.
