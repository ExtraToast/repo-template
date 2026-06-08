# Pending workflows

These are the repo's real CI/release workflows. They live here, not in
`.github/workflows/`, because the automation account (the `personal-stack-agents`
GitHub App) is not granted the `workflows` permission and so cannot push files
under `.github/workflows/`.

To activate (one-time, by an actor with `workflows` permission — i.e. a human
push or a token with the `workflow` scope):

```bash
git mv .github/workflows-pending/ci.yml      .github/workflows/ci.yml
git mv .github/workflows-pending/release.yml .github/workflows/release.yml
git rm .github/workflows-pending/README.md
git commit -m "ci: activate Pipeline Complete + release workflows"
git push
```

The permanent fix is to grant the App `workflows: write` and have the
installation-token minter request it; then automation can manage workflows
directly.
