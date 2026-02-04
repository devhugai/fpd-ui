---
trigger: always_on
---

# Code Style Guide - FPDUI

## General Principles
- **Linting:** Follow `flutter_lints` or strict linter rules.
- **Prefix:** All public-facing widgets and packages NOT shadowed by shadcn naming (if any conflict arises) should consider the `fpd` or `Fpd` prefix, though for this port we aim for `shadcn` naming parity (e.g., `Button`, `Card`).
  - *Correction based on User Request:* "el prefijo de todo lo que se cree es fpdui".
  - **Rule:** If the component is a direct port, match the name (e.g., `FpdButton` or just `Button` inside the package). *Decision:* To avoid conflicts with Flutter Material usage, prefer namespaced imports or specific prefixes if strictly requested.
  - **Package Name:** `fpdui`

## Dart & Flutter Best Practices
- **Immutability:** Usage of `const` constructors wherever possible.
- **State Management:** `flutter_riverpod` v2+ (Code Generation enabled/preferred).
- **Asynchronous Code:** `async`/`await` over `.then()`.

## Directory Structure
- Follow the feature-first or component-based structure defined in the Master Plan.
  ```
  lib/
    components/
      button/
        button.dart
        button_theme.dart
  ```

## File Naming
- Snake case for files: `my_component.dart`.
- Classes: PascalCase `MyComponent`.
- Extensions: `MyComponentExtension`.

## Code Comments
- Use `///` for public API documentation (Effective Dart).
- Explain *why*, NOT *what*.

## Dependencies
- Use specific versions in `pubspec.yaml` (avoid unbounded `^` if stability is critical).
- **Formatting:** `dart format` (80 chars line length).
