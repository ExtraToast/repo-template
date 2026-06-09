# Tasks: Round 3 Policy, Tooling, and Docker Pattern Templates

**Input**: Design documents from `/specs/001-round3-policy-tooling-docker/`
**Prerequisites**: plan.md (required), research.md, data-model.md, contracts/

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel with other tasks because it touches different files
- **[Story]**: User story label, for example US1, US2, US3
- Include exact file paths in descriptions

## Phase 1: Setup

- [x] T001 Create `specs/001-round3-policy-tooling-docker/` with spec, plan, research, data model, contracts, quickstart, and tasks.
- [x] T002 Identify `scripts/validate-templates.sh` as the smallest validation command.

## Phase 2: Foundational

- [x] T003 Create `templates/` layout for dependency policy, root tooling, and Docker pattern assets.
- [x] T004 Add validation coverage for syntax, policy invariants, design-only Docker skeletons, and forbidden source values.

## Phase 3: User Story 1 (Priority: P1)

**Goal**: Dependency policy templates are parameterized and validate locally.

**Independent Test**: `scripts/validate-templates.sh`

- [x] T005 [US1] Add dependency policy templates in `templates/dependency-policy/`.
- [x] T006 [US1] Update active `.github/dependabot.yml` and `renovate.json` defaults.

## Phase 4: User Story 2 (Priority: P2)

**Goal**: Root tooling and docs/ADR presets are available as neutral templates.

**Independent Test**: `scripts/validate-templates.sh`

- [x] T007 [P] [US2] Add root tooling templates in `templates/root-tooling/`.
- [x] T008 [P] [US2] Add docs and ADR templates in `templates/root-tooling/docs/`.

## Phase 5: User Story 3 (Priority: P3)

**Goal**: Docker pattern skeletons are present without production implementation.

**Independent Test**: `scripts/validate-templates.sh`

- [x] T009 [P] [US3] Add design-only skeletons in `templates/docker-patterns/`.

## Phase 6: Polish

- [x] T010 Run `scripts/validate-templates.sh`.
- [x] T011 Update `docs/REPO_SETUP.md` and `README.md` to reference new templates.
