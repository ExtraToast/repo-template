# Contract: Docker Pattern Skeletons

Docker pattern skeletons must:

- Be clearly labeled as design-only.
- Use placeholders for images, ports, users, paths, jar names, build commands, and runtime flags.
- Keep JVM, CRaC JVM, OTel entrypoint, Vue build/runtime, pnpm, Yarn, privileged nginx, and unprivileged nginx concerns in separate files.
- Not implement a production renderer.
- Not provide a single shared Dockerfile for all services.
- Avoid source-repo-specific domains, hostnames, namespaces, image prefixes, queue/exchange names, paths, IPs, and vendor URLs.
