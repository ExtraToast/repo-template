# Docker Pattern Skeletons

These files are design-first skeletons for future extraction work. They are not
production Dockerfiles and they intentionally do not define one shared
Dockerfile for every service.

Patterns included:

- `jvm/Dockerfile.jvm.tmpl`: ordinary JVM service runtime.
- `jvm/Dockerfile.crac-jvm.tmpl`: CRaC-capable JVM service runtime.
- `entrypoints/otel-entrypoint.sh.tmpl`: OpenTelemetry entrypoint wrapper.
- `vue/Dockerfile.vue-build-runtime.tmpl`: Vue build plus nginx runtime shape.
- `vue/Dockerfile.pnpm-build.tmpl`: pnpm-focused build skeleton.
- `vue/Dockerfile.yarn-build.tmpl`: Yarn-focused build skeleton.
- `nginx/Dockerfile.privileged-nginx.tmpl`: privileged nginx runtime shape.
- `nginx/Dockerfile.unprivileged-nginx.tmpl`: unprivileged nginx runtime shape.

Future production implementation must choose concrete base images, user IDs,
ports, health checks, cache policy, SBOM/signing policy, and OTel conventions per
target repository.
