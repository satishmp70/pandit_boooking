# syntax=docker/dockerfile:1

# ---------------------------------------------------------------------------
# Stage 1 - build the Flutter web bundle
# ---------------------------------------------------------------------------
# Uses the official community Flutter image. If `flutter pub get` complains
# about the Dart SDK constraint in pubspec.yaml, bump this tag to a newer
# Flutter release.
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Copy the dependency manifests first so the pub cache layer is reused
# whenever only application code changes.
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Now copy the rest of the sources and produce the release bundle.
COPY . .
RUN flutter build web --release

# ---------------------------------------------------------------------------
# Stage 2 - serve the static bundle
# ---------------------------------------------------------------------------
FROM nginx:1.27-alpine AS runtime

# SPA-aware nginx config (client-side routing fallback).
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Only the compiled web output is shipped in the final image.
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ >/dev/null 2>&1 || exit 1

CMD ["nginx", "-g", "daemon off;"]
