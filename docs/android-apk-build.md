# Build the Android APK

Run commands from the project root. The APK includes the current local source,
including uncommitted changes. The application currently uses mock data.

## Docker build (no local Flutter installation)

Requirements: Docker Engine with Docker Compose, an internet connection for the
first build, and several GB of free disk space. The configuration pins the Flutter
image used for this project to Flutter 3.44.0 / Dart 3.12.0.

```bash
mkdir -p build/android-apk
docker compose -f docker-compose.android.yml run --rm apk
```

On Linux, if your user/group IDs are not 1000, use:

```bash
OUTPUT_UID=$(id -u) OUTPUT_GID=$(id -g) docker compose -f docker-compose.android.yml run --rm apk
```

Output: **`build/android-apk/PanditBooking-latest.apk`**.

Run the same command after changing the app to rebuild. Each run copies the
current source into a fresh container, builds a universal release APK, verifies
its signature, then replaces the output file. A failed build leaves the previous
APK intact; check for successful command completion before sharing it.

The first build downloads Gradle, Android SDK/NDK components and dependencies and
can take several minutes. Docker volumes retain those tools, package caches and
the test-signing key for later builds. Keep the `android-signing` volume to retain
the same signing identity. Do not run concurrent APK builds against these caches.
This build does not require or start the web container.

## Build with Flutter installed locally

Install Flutter and the Android SDK/JDK, then check the environment and accept
the Android SDK licenses:

```bash
flutter doctor
flutter doctor --android-licenses
flutter pub get
flutter build apk --release
```

Output: **`build/app/outputs/flutter-apk/app-release.apk`**.

For smaller APKs, one per processor architecture:

```bash
flutter build apk --release --split-per-abi
```

These files are also written to `build/app/outputs/flutter-apk/`. Most recent
physical Android phones use the `arm64-v8a` APK; use the universal APK when unsure.

## Install and share

Transfer the APK to an Android phone, open it, and allow installation from the
app used to open the file if prompted. With Android platform tools installed and
USB debugging enabled, you can also run:

```bash
adb install -r build/android-apk/PanditBooking-latest.apk
```

The application ID is `com.panditbooking.app`. The verified build requires Android
7.0 (API 24) or newer. A successful build/signature check does not replace testing
the app on a device.

## Version and signing

Set the version in `pubspec.yaml`, for example `version: 1.0.1+2` (version name
`1.0.1`, Android version code `2`), before building a new version.

The current release configuration in `android/app/build.gradle.kts` uses a debug
signing key. These are release-mode builds for testing, not production-signed
store releases. Configure a private production keystore before publishing.

Docker and local builds can use different test-signing keys. If Android reports
an incompatible update, use the original signing key, or uninstall the old app
before installing the new APK. **Uninstalling deletes that app's local data.**

## Troubleshooting

- Docker socket permission error: run with an account allowed to access Docker.
- Dependency download failure: check internet access, then repeat the build.
- A Kotlin migration warning alone does not indicate build failure; check the
  final Gradle result and command exit status.
- `docker compose up --build` builds the web app. Use the separate Android
  Compose file shown above to produce an APK.
