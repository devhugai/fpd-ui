# Agent Rules

## Path Separators
- **Windows Only:** MUST use backslash `\` for all file paths.
- **Forbidden:** Do NOT use forward slash `/`.
- **Reason:** To prevent malformed paths like `fpdui\libcomponents` during path concatenation.
