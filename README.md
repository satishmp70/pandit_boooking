# DivyaSeva — Pandit Booking

A standalone Flutter app to book a verified Pandit for home ceremonies —
discover a service, configure the date, muhurat and samagri, match a Pandit,
pay, and follow the service through preparation, live tracking and completion.

The app is built with a feature-first Clean Architecture layout
(`domain` / `data` / `presentation`) and `flutter_bloc` state management, and
ships with local mock data sources so it runs without a backend.

## Project structure

```
lib/
  core/                 # theme, shared widgets, dependency injection
  features/
    auth/               # splash, login, OTP
    divyaseva/          # home, discover, booking wizard, matching,
                        # bookings, account, partner (Pandit portal)
  routes/               # go_router configuration
```

## Getting Started

This project is a Flutter application targeting Android, iOS, web, and desktop.

### Prerequisites

- Flutter SDK (stable channel)
- Dart SDK (bundled with Flutter)

### Run

```bash
flutter pub get
flutter run
```

### Quality checks

```bash
flutter analyze
flutter test
```

The application ships with local mock data sources, so it runs without any
backend configuration.

## Build an Android APK

See [Android APK build instructions](docs/android-apk-build.md) for Docker and
local Flutter builds, installation, versioning, and signing.

```bash
mkdir -p build/android-apk
docker compose -f docker-compose.android.yml run --rm apk
```

Output: `build/android-apk/PanditBooking-latest.apk`.
The release APK currently uses a persistent test-signing key.

## Run with Docker

The Docker image builds the Flutter **web** release and serves it with nginx,
so the app can be run on any machine that has Docker — no Flutter SDK required.

### Prerequisites

- Docker Engine 24+ with the Compose plugin

### Production (nginx)

```bash
docker compose up --build -d
```

Then open <http://localhost:8080>. To use a different port:

```bash
WEB_PORT=3000 docker compose up --build -d
```

Stop it with:

```bash
docker compose down
```

### Development (live source mount)

```bash
docker compose --profile dev up --build
```

This runs `flutter run -d web-server` inside the container with the project
mounted, serving at <http://localhost:8080>.

### Notes

- The build uses `ghcr.io/cirruslabs/flutter:stable`. If `flutter pub get`
  reports a Dart SDK constraint error, update the image tag in `Dockerfile`
  and `docker-compose.yml` to a newer Flutter release.
- Only the compiled web bundle is included in the final image; the mobile and
  desktop platform folders are excluded via `.dockerignore`.
