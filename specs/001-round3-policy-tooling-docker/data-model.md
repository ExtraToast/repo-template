# Data Model: Round 3 Template Assets

## DependencyPolicyTemplate

- `name`: human-readable template name.
- `manager`: Dependabot, Renovate, dependency-review, Scorecard, or CodeQL.
- `parameters`: placeholders a consumer must fill, such as directories, default branch, languages, build commands, and generated path ignores.
- `policyInvariants`: required behavior that validation checks, such as 7-day delay and minor/patch grouping.

## RootToolingPreset

- `name`: preset name.
- `packageManager`: `pnpm`, `yarn`, or `agnostic`.
- `files`: template files copied into the target repository.
- `optionalSnippets`: local-only strict checks, such as pre-commit Detekt/Ktlint commands.
- `generalizationRules`: values that must stay parameterized and not source-specific.

## DockerPatternSkeleton

- `name`: pattern name.
- `runtimeConcern`: JVM, CRaC JVM, OTel, Vue, package manager, or nginx.
- `placeholderInputs`: values a future production implementation must request from the target repository.
- `nonGoals`: behavior intentionally excluded in this round.

## TemplateValidation

- `syntaxChecks`: JSON parsing and optional YAML parsing.
- `policyChecks`: grep-based assertions for required policy markers.
- `leakChecks`: known source-repo-specific values that must not appear in templates.
