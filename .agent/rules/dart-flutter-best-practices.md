---
trigger: always_on
---

# Dart and Flutter Best Practices Guide (2024-2025)

This guide outlines the industry-standard best practices for developing high-quality, maintainable, and performant applications using Dart and Flutter.

---

## 1. Code Style & Naming Conventions

Consistency is key to maintainability. Follow the "Effective Dart" guidelines.

### Naming Conventions
- **Classes, Enums, Typedefs, and Extensions**: Use `PascalCase`.
  ```dart
  class UserProfile { ... }
  enum StatusType { active, inactive }
  ```
- **Libraries, Packages, Directories, and Source Files**: Use `snake_case`.
  ```text
  lib/views/user_profile_page.dart
  ```
- **Variables, Properties, and Functions**: Use `camelCase`.
  ```dart
  final String userName = 'John';
  void fetchData() { ... }
  ```

### Formatting
- Use **2 spaces** for indentation.
- Use **trailing commas** for all parameter and argument lists to improve diffs and formatting.
- Prefer **double quotes** for strings unless the string contains double quotes, then use single quotes.

---

## 2. Linting & Code Quality

Automated checks prevent common mistakes and enforce style.

- **Enable Lints**: Always include `flutter_lints` in your `pubspec.yaml`.
- **Custom Rules**: Customize `analysis_options.yaml` to suit your team's needs.
  ```yaml
  include: package:flutter_lints/flutter.yaml
  linter:
    rules:
      - prefer_const_constructors
      - always_declare_return_types
      - avoid_print
      - use_build_context_synchronously
  ```
- **Strict Typing**: Enable strict mode in `analysis_options.yaml` for production apps:
  ```yaml
  analyzer:
    language:
      strict-casts: true
      strict-inference: true
      strict-raw-types: true
  ```

---

## 3. Project Architecture

Choosing a scalable architecture is critical for large applications.

### Folder Structure (Feature-First)
Organize by feature rather than layer for better modularity.
```text
lib/
  src/
    features/
      auth/
        data/
        domain/
        presentation/
      home/
        data/
        domain/
        presentation/
    shared/
      widgets/
      utils/
```

### Clean Architecture Principles
- **Presentation**: UI and State Management.
- **Domain**: Business Logic and Entities (Pure Dart).
- **Data**: Data Sources (API, DB) and Repositories.

---

## 4. Performance Optimization

### Widget Rebuilds
- Use **`const` constructors** whenever possible to avoid unnecessary rebuilds.
- Minimize the scope of `setState()`.
- Use `RepaintBoundary` for complex animations or static parts of a frequently updating UI.

### Async Operations
- Use `FutureBuilder` or `StreamBuilder` for declarative async UI.
- Offload CPU-heavy tasks (like JSON parsing of large datasets) to **Isolates**.
- Always check `mounted` before calling `setState()` or using `BuildContext` in async methods.

---

## 5. State Management

Choose the tool that fits your project's complexity:

| Complexity | Recommended Tool | Why? |
| :--- | :--- | :--- |
| **Small** | `Provider` | Simple, easy to learn, official recommendation. |
| **Medium** | `Riverpod` | Compile-safe, no BuildContext dependency, flexible. |
| **Large/Enterprise** | `BLoC / Mason` | Strict separation of concerns, highly testable, event-driven. |

---

## 6. Testing Strategy

Aim for high coverage but focus on value.

- **Unit Tests**: Test business logic and entities (Domain layer).
- **Widget Tests**: Test individual components in isolation.
- **Integration Tests**: Test the end-to-to-end user flows on real devices/emulators.
- **Golden Tests**: Ensure UI consistency and prevent visual regressions.

---

## 7. Resource & Dependency Management

- **Assets**: Use `flutter_gen` to generate type-safe asset references.
- **Dependencies**: 
  - Pin versions in `pubspec.yaml` for production.
  - Audit licenses of third-party packages.
  - Avoid "God Classes" and excessive dependencies that bloat the app size.

---

## 8. Documentation

- Use **triple-slash `///` documentation comments** for all public APIs.
- provide examples in doc comments using markdown.
- use `@Deprecated` with clear migration paths for breaking changes.
