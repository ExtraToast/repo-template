# Implementation Plan: Round 3 Policy, Tooling, and Docker Pattern Templates

**Branch**: `001-round3-policy-tooling-docker` | **Date**: 2026-06-09 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-round3-policy-tooling-docker/spec.md`

## Summary

Add reusable repo-template assets for round-3 dependency policy and root dev-tooling extraction, and add design-first Docker pattern skeletons only. The implementation uses static templates under `templates/`, updates active dependency defaults where this repo already carries policy files, and adds a local validation script that runs without network access.

## Technical Context

**Language/Version**: Shell, JSON, YAML, Markdown, TypeScript config snippets
**Primary Dependencies**: Bash, local Python standard library for JSON parsing; optional local Ruby/Python YAML parser if already available
**Storage**: Files in repository
**Testing**: `scripts/validate-templates.sh`
**Target Platform**: GitHub repository template consumers
**Project Type**: repository template / tooling
**Performance Goals**: Validation completes in under 5 seconds locally
**Constraints**: No networked build; no modification of read-only reference repos; Docker patterns are skeletons only; keep one CI terminal `Pipeline Complete` job convention unchanged
**Scale/Scope**: One Spec Kit feature plus template assets for repository onboarding

## Constitution Check

- [x] No attribution is introduced in files, comments, commit text, or PR text
- [x] Claude/Codex parity is preserved for any agent-facing behavior
- [x] Rendered artifacts are updated by the owning renderer when source changes require it
- [x] Small stacked PR boundary is clear and unrelated cleanup is excluded
- [x] Verification command is identified for each touched area

## Project Structure

### Documentation

```text
specs/001-round3-policy-tooling-docker/
|-- plan.md
|-- research.md
|-- data-model.md
|-- quickstart.md
|-- contracts/
|   |-- dependency-policy-template.md
|   |-- root-tooling-preset.md
|   `-- docker-pattern-skeleton.md
`-- tasks.md
```

### Source Code

```text
.github/dependabot.yml
renovate.json
docs/REPO_SETUP.md
templates/dependency-policy/
templates/root-tooling/
templates/docker-patterns/
scripts/validate-templates.sh
```

**Structure Decision**: Active defaults remain in the repo root where GitHub and Renovate expect them. Parameterized variants live under `templates/` so consumers can copy the correct stack-specific files without making this repository's own active workflows invalid.

## Phase 0: Outline & Research

1. Extract source policy from `/workspace/personal-stack` and `/workspace/website`.
2. Generalize all source-specific paths, domains, namespaces, image names, queues, exchanges, and IP addresses.
3. Keep Docker work design-first with skeleton fixtures only.

**Output**: `research.md`

## Phase 1: Design & Contracts

1. Document template entities in `data-model.md`.
2. Document template contracts in `contracts/`.
3. Write `quickstart.md` with local validation steps.
4. Re-run Constitution Check.

**Output**: `data-model.md`, `contracts/*`, `quickstart.md`

## Phase 2: Task Planning Approach

Tasks are split into spec creation, dependency policy extraction, root tooling extraction, Docker skeleton design, and local validation. Dependency policy lands before tooling because onboarding policy files are independent of application stack.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
| --- | --- | --- |
| N/A | N/A | N/A |

## Progress Tracking

**Phase Status**:

- [x] Phase 0: Research complete
- [x] Phase 1: Design complete
- [x] Phase 2: Task planning approach complete

**Gate Status**:

- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
