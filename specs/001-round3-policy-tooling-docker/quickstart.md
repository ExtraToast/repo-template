# Quickstart: Round 3 Template Assets

## Validate Locally

```bash
scripts/validate-templates.sh
```

The script performs only local checks. It does not install dependencies, contact registries, run Gradle, run npm, or call GitHub.

## Use Dependency Policy Templates

1. Copy the needed files from `templates/dependency-policy/` into a new repository.
2. Replace `{{...}}` placeholders with repository-specific directories, languages, and branches.
3. Keep 7-day release delay/cooldown settings unless a repository has an explicit risk exception.

## Use Root Tooling Presets

1. Choose `templates/root-tooling/package/pnpm-package.json` or `templates/root-tooling/package/yarn-package.json`.
2. Copy the shared root config files.
3. Enable strict pre-commit snippets only after the repository already has the referenced Gradle or frontend tasks.

## Review Docker Skeletons

Read `templates/docker-patterns/README.md` first. The files are design placeholders, not production Dockerfiles.
