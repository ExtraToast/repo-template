# Contract: Root Tooling Presets

Root tooling presets must:

- Include editorconfig, Prettier, ESLint, lint-staged, Husky, and gitleaks variants.
- Include pnpm and Yarn package script variants.
- Keep generated-client paths and ignored directories configurable.
- Keep strict pre-commit snippets optional.
- Use `config/detekt/detekt.yml` as the Detekt config default.
- Include ADR and docs index templates with neutral project names and status definitions.
- Avoid source-repo-specific service names, domains, queue names, or stack paths.
