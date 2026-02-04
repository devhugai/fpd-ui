---
trigger: always_on
---

# Commit Style Guide - FPDUI

## Philosophy
- **Atomic Commits:** Each commit should do one thing and do it well. Avoid bundling unrelated changes (e.g., a bug fix + a feature + formatting changes) in a single commit.
- **Frequency:** Commit often. Ideally, every time you complete a sub-task or a logical unit of work that compiles and runs.

## Format: Conventional Commits
We follow [Conventional Commits](https://www.conventionalcommits.org/):

`type(scope): description`

### Types
- **feat:** A new feature (e.g., `feat(button): add ghost variant`).
- **fix:** A bug fix (e.g., `fix(input): resolve border color issue`).
- **docs:** Documentation only changes (e.g., `docs: update readme`).
- **style:** Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc).
- **refactor:** A code change that neither fixes a bug nor adds a feature.
- **perf:** A code change that improves performance.
- **test:** Adding missing tests or correcting existing tests.
- **chore:** Changes to the build process or auxiliary tools and libraries.

### Scope
Optional but recommended. Indicates the module or component affected (e.g., `button`, `router`, `theme`, `docs`).

### Description
- Use the imperative, present tense: "change" not "changed" nor "changes".
- Don't capitalize the first letter.
- No period (.) at the end.

## Example
```text
feat(theme): add support for dark mode switching
fix(card): correct padding on mobile layout
docs: add commit style guide
```
