#!/usr/bin/env bash
# Validate repo-template static assets without network access.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail() {
  echo "validate-templates: $*" >&2
  exit 1
}

log() {
  echo "validate-templates: $*"
}

json_files=(
  renovate.json
  templates/dependency-policy/renovate.json.tmpl
  templates/root-tooling/package/pnpm-package.json
  templates/root-tooling/package/yarn-package.json
  templates/root-tooling/hooks/lintstagedrc.json.tmpl
  templates/root-tooling/prettierrc.json.tmpl
)

log "checking JSON syntax"
python3 - "$ROOT" "${json_files[@]}" <<'PY'
import json
import pathlib
import sys

root = pathlib.Path(sys.argv[1])
for rel in sys.argv[2:]:
    path = root / rel
    with path.open("r", encoding="utf-8") as fh:
        json.load(fh)
PY

yaml_files=(
  .github/dependabot.yml
  templates/dependency-policy/dependabot.yml.tmpl
  templates/dependency-policy/dependency-review.yml.tmpl
  templates/dependency-policy/scorecard.yml.tmpl
  templates/dependency-policy/codeql.yml.tmpl
  templates/dependency-policy/codeql-config.yml.tmpl
)

log "checking YAML syntax when a local parser is available"
python3 - "$ROOT" "${yaml_files[@]}" <<'PY'
import importlib.util
import pathlib
import sys

if importlib.util.find_spec("yaml") is None:
    print("validate-templates: PyYAML unavailable; skipped YAML parser check")
    raise SystemExit(0)

import yaml

root = pathlib.Path(sys.argv[1])
for rel in sys.argv[2:]:
    path = root / rel
    with path.open("r", encoding="utf-8") as fh:
        yaml.safe_load(fh)
PY

log "checking dependency policy invariants"
grep -R "default-days: 7" .github/dependabot.yml templates/dependency-policy/dependabot.yml.tmpl >/dev/null \
  || fail "Dependabot policy must include 7-day cooldown"
grep -R "\"minimumReleaseAge\": \"7 days\"" renovate.json templates/dependency-policy/renovate.json.tmpl >/dev/null \
  || fail "Renovate policy must include 7-day minimum release age"
grep -R "update-types: \\[minor, patch\\]" templates/dependency-policy/dependabot.yml.tmpl >/dev/null \
  || fail "Dependabot template must group minor and patch updates"
grep -R "\"matchUpdateTypes\": \\[\"minor\", \"patch\"\\]" renovate.json templates/dependency-policy/renovate.json.tmpl >/dev/null \
  || fail "Renovate policy must group minor and patch updates"
grep -R "security-updates" templates/dependency-policy/dependabot.yml.tmpl .github/dependabot.yml >/dev/null \
  || fail "Dependabot policy must group security updates"
grep -R "vulnerabilityAlerts" templates/dependency-policy/renovate.json.tmpl >/dev/null \
  || fail "Renovate template must enable vulnerability alerts"
grep -R "extratoast shared artifacts" renovate.json templates/dependency-policy/renovate.json.tmpl >/dev/null \
  || fail "Optional ExtraToast shared-artifact grouping missing"

log "checking root tooling invariants"
grep -R "config/detekt/detekt.yml" templates/root-tooling >/dev/null \
  || fail "Detekt default path must align with gradle-conventions"
grep -R "lint-staged" templates/root-tooling/hooks templates/root-tooling/package >/dev/null \
  || fail "lint-staged preset missing"
grep -R "prettier --check" templates/root-tooling/package templates/root-tooling/hooks >/dev/null \
  || fail "format check preset missing"

log "checking Docker skeleton boundaries"
docker_skeleton_count="$(find templates/docker-patterns -type f -name '*.tmpl' | wc -l | tr -d ' ')"
[[ "$docker_skeleton_count" -ge 8 ]] || fail "expected at least 8 Docker pattern skeletons"
[[ ! -f templates/docker-patterns/Dockerfile.tmpl ]] || fail "single shared Dockerfile skeleton is not allowed"
grep -R "DESIGN-ONLY SKELETON" templates/docker-patterns >/dev/null \
  || fail "Docker pattern skeletons must be marked design-only"

log "checking for source-specific values in templates"
forbidden_pattern='jorisjonkers|esa-blueshell|blueshell|personal-stack|frankfurt-contabo|enschede|167\.86\.79\.203|130\.89\.174\.190|192\.168\.0\.99|auth-system|assistant-system|knowledge-system|media-system|utility-system|data-system|secret/data/platform|secret/platform|secret/agents|auth-api|assistant-api|knowledge-api|uptime-kuma|stalwart|rabbitmq|valkey|postgres'
if rg -n -i "$forbidden_pattern" templates; then
  fail "source-specific value found in templates"
fi

log "all checks passed"
