# Bootstrapping a new ExtraToast repo from this template

1. **Create the repo from the template** (GitHub "Use this template", or
   `gh repo create ExtraToast/<name> --template ExtraToast/repo-template
   --private`).
2. **Apply the branch ruleset** so `Pipeline Complete` is required:
   ```bash
   scripts/apply-ruleset.sh ExtraToast/<name>
   ```
3. **Wire the real CI**: replace the placeholder `lint`/`test`/`coverage`/`build`
   jobs in `.github/workflows/ci.yml` with this repo's actual jobs (or calls
   into reusable workflows from `ExtraToast/github-workflows`). Keep the
   `pipeline-complete` aggregator and list every gating job in its `needs:`.
4. **Wire the coverage gate**: every repo must enforce **>=80% line coverage**.
   - Gradle: apply JaCoCo and run `jacocoTestCoverageVerification` with a line
     coverage minimum of `0.80`.
   - Node: run Vitest with c8 coverage enforcement, for example `c8 --lines 80
     vitest run`.
5. **Set the release artifact**: edit `release.yml`'s `publish` job for this
   repo's artifact type (Maven / npm / image), and set `release-type` in
   `release-please-config.json` accordingly. New GitHub Packages publish as
   public on this account, but verify package visibility after the first
   publish.
6. **Set the starting version** in `.release-please-manifest.json`.
7. **CODEOWNERS / README**: adjust owners and replace this README's body with
   the repo's purpose.
8. **Enable Renovate** (GitHub App) on the repo; `renovate.json` is already
   present.

## What this template provides

| File | Purpose |
| --- | --- |
| `.github/workflows/ci.yml` | One CI pipeline ending in the `Pipeline Complete` gate, including a coverage gate placeholder |
| `.github/workflows/release.yml` | release-please tag/release + artifact publish |
| `.github/rulesets/main.json` + `scripts/apply-ruleset.sh` | Org ruleset as code (requires `Pipeline Complete`) |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR template (tracking + verification + versioning) |
| `.github/ISSUE_TEMPLATE/*` | Bug / feature / task forms |
| `.github/CODEOWNERS`, `dependabot.yml`, `renovate.json` | Ownership + dependency automation |
| `release-please-config.json`, `.release-please-manifest.json` | Versioning state |
| `CONTRIBUTING.md`, `VERSIONING.md`, `SECURITY.md` | Conventions |
| `.editorconfig`, `.gitignore`, `.gitleaks.toml`, `LICENSE` | Baseline hygiene |
