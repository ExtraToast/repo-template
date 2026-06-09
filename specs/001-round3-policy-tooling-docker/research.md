# Research: Round 3 Policy, Tooling, and Docker Pattern Templates

## Dependency Policy

Reference dependency files encode four reusable choices:

- Delay dependency PRs for 7 days after publication.
- Group minor and patch updates so routine maintenance lands together.
- Keep major version updates outside routine groups so breaking changes are isolated.
- Group security updates separately because security fixes should not wait behind ordinary update queues.

Renovate remains the primary manager for the template repository. Dependabot templates are provided for repositories that use Dependabot directly or keep Dependabot as a fallback for GitHub Actions/security updates.

## Root Tooling

Reference repos use two frontend package-manager patterns:

- pnpm workspace root with recursive scripts and Husky/lint-staged.
- Yarn application package with direct scripts and generated-client commands.

Reusable extraction keeps package-manager scripts, ESLint variants, Prettier, editorconfig, gitleaks, lint-staged, Husky, ADR indexes, and docs indexes. Source-specific stack health checks, service names, domains, generated-client paths, and Docker Compose service lists stay out of the preset.

Detekt defaults align with gradle-conventions by using `config/detekt/detekt.yml` and Gradle tasks (`detekt`, `ktlintCheck`) instead of hardcoded source-repo paths.

## Docker Pattern Design

Dockerfile and entrypoint patterns are design-first in this round. Skeletons are split by concern:

- JVM service runtime
- CRaC JVM runtime
- OTel entrypoint wrapper
- Vue build/runtime
- pnpm build
- Yarn build
- privileged nginx runtime
- unprivileged nginx runtime

No production renderer or single shared Dockerfile is implemented.
