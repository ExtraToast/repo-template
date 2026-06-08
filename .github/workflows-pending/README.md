# Pending workflows

These are the repo's real CI/release workflows. They live here, not in
`.github/workflows/`, because the automation account (the `personal-stack-agents`
GitHub App) cannot push files under `.github/workflows/` — the installation
token it is minted with does not include the `workflows` permission.

Activate (one-time, by an actor whose token carries the `workflow` scope):

```bash
git mv .github/workflows-pending/ci.yml      .github/workflows/ci.yml
git mv .github/workflows-pending/release.yml .github/workflows/release.yml
git rm .github/workflows-pending/README.md
git commit -m "ci: activate Pipeline Complete + release workflows" && git push
```

Permanent fix: grant the App `workflows: write` (done at the App level) AND have
the installation-token minter request `workflows: write` so issued tokens carry it.
