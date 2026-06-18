# AGENTS.md

Guidance for coding agents working in the BrickClub repository.

## Project Overview

BrickClub is a Flutter application backed by Firebase. The app includes a web landing page, mobile-style member flows, KYC flows, admin operations, Firebase Authentication, Firestore, Storage, and callable Cloud Functions.

Local development can target either the cloud `brickclub` project (the default) or the Firebase Emulator Suite. Running against cloud in dev is a supported workflow on all platforms (web, Android, iOS, Windows, Linux); a plain `flutter run` connects to cloud, and you opt into emulators with `--dart-define=USE_FIREBASE_EMULATORS=true` (see Flutter Commands). Web, Android, and iOS apps are registered in the `brickclub` project, and their real options live in `lib/src/core/firebase/default_firebase_options.dart`. Firebase initializes from those Dart options, so native config files (`google-services.json`, `GoogleService-Info.plist`) are not required.

The app now defaults to cloud, so routine `flutter run` work hits real cloud data and quota. Be careful: never deploy or mutate cloud data unless the user explicitly asks, and prefer the emulators (`USE_FIREBASE_EMULATORS=true`) for destructive or experimental backend work.

## Repository Layout

- `lib/main.dart` bootstraps Flutter, initializes Firebase, and wires app-level repositories into `BrickClubApp`.
- `lib/src/app/` contains the main UI, routing gate, shared visual components, colors, and text styles.
- `lib/src/core/firebase/` contains Firebase initialization, emulator connection logic, generated-style Firebase options, and shared callable Function clients.
- `lib/src/features/auth/` contains authentication domain contracts and Firebase implementation.
- `lib/src/features/kyc/` contains KYC domain contracts/models and Firebase implementation.
- `lib/src/features/admin/` contains admin domain contracts/models and Firebase implementation.
- `functions/src/` contains Firebase Cloud Functions and privileged backend logic.
- `functions/scripts/` contains helper scripts, including admin-claim setup for emulator or trusted environments.
- `assets/images/` contains app and landing-page image assets.
- `test/` contains Flutter widget tests with fake repositories.
- `firestore.rules`, `storage.rules`, and `firestore.indexes.json` define Firebase security and index configuration.

## Architecture Rules

- Keep Firebase SDK calls out of widgets where practical. Widgets should depend on domain repositories or core service clients.
- Put app-facing contracts in `lib/src/features/*/domain/`.
- Put Firebase-specific implementations in `lib/src/features/*/data/`.
- Put shared Firebase bootstrap/client code in `lib/src/core/firebase/`.
- Keep privileged operations in Cloud Functions, especially user management, custom claims, and admin-only CRUD.
- Admin callable Functions must require authentication and the `admin: true` custom claim.
- Do not duplicate backend authorization in Flutter as the only enforcement. Client checks are UX only.
- Prefer typed models and explicit payload parsing over loosely shaped maps.

## Flutter Commands

Install dependencies:

```powershell
flutter pub get
```

Run the app against the cloud `brickclub` project (the default — no flag needed):

```powershell
flutter run -d chrome
```

This uses real cloud services and data, requires deployed Cloud Functions, and sends real verification email/SMS. Works on web, Android, iOS, Windows, and Linux (run with `-d <device>` to target a specific device); Android phone-auth additionally needs the signing SHA added to the Firebase Console.

Run the app with local Firebase emulators instead:

```powershell
flutter run --dart-define=USE_FIREBASE_EMULATORS=true
```

For a physical device on the same network using the emulators, pass the host machine IP:

```powershell
flutter run --dart-define=USE_FIREBASE_EMULATORS=true --dart-define=FIREBASE_EMULATOR_HOST=192.168.1.20
```

Analyze and test:

```powershell
flutter analyze
flutter test
```

Production builds already default to cloud; pass the flag explicitly to be safe:

```powershell
flutter build web --dart-define=USE_FIREBASE_EMULATORS=false
flutter build apk --dart-define=USE_FIREBASE_EMULATORS=false
```

## Firebase Emulator Workflow

Install required tools if missing:

```powershell
npm install -g firebase-tools
dart pub global activate flutterfire_cli
docker --version
java -version
```

Java 21 or newer is required for the Firestore emulator.

Install Cloud Functions dependencies:

```powershell
npm --prefix functions install
```

Start Mailpit for local email testing:

```powershell
docker compose up -d mailpit
```

Start Firebase emulators:

```powershell
firebase emulators:start --only auth,functions,firestore,storage
```

Useful local URLs:

- Firebase Emulator UI: `http://localhost:4000`
- Auth emulator UI: `http://localhost:4000/auth`
- Mailpit inbox: `http://localhost:8025`
- Mailpit SMTP: `localhost:1025`

Emulator ports are configured in `firebase.json`:

- Auth: `9099`
- Functions: `5001`
- Firestore: `8080`
- Storage: `9199`
- Emulator UI: `4000`

The app defaults to cloud; pass `--dart-define=USE_FIREBASE_EMULATORS=true` to use the emulators. When emulators are enabled, the Android emulator uses `10.0.2.2`; web, Windows, iOS simulator, and macOS use `localhost` unless `FIREBASE_EMULATOR_HOST` is provided.

## Cloud Functions Commands

Build Functions:

```powershell
npm --prefix functions run build
```

Lint Functions:

```powershell
npm --prefix functions run lint
```

Run backend emulators through the Functions package:

```powershell
npm --prefix functions run serve
```

Set an emulator admin claim:

```powershell
$env:FIREBASE_AUTH_EMULATOR_HOST="127.0.0.1:9099"
$env:GCLOUD_PROJECT="brickclub"
npm --prefix functions run claim:admin -- admin@brickclub.com
```

After changing custom claims, sign out and sign back in so the app receives a fresh ID token.

## Local Test Accounts

Current local defaults used by the UI:

- Member email: `joshua@brickclub.com`
- Admin email: `admin@brickclub.com`
- Password: `password10`

Create users in the Auth emulator UI or through the app sign-up flow.

## Development Email and Phone Verification

Password reset and KYC email verification in development are sent by the Functions emulator to Mailpit. Start Mailpit before triggering those flows.

KYC phone verification uses Firebase Auth phone verification. When connected to the Auth emulator, no real SMS is sent. Trigger a code from the KYC screen, then read the displayed verification code in the Auth emulator UI.

## Style and Implementation Notes

- Follow `analysis_options.yaml`, which includes `package:flutter_lints/flutter.yaml`.
- Use Material 3 conventions already present in the app.
- Keep visual changes consistent with the existing dark BrickClub palette and shared `AppColors`/`AppText` definitions.
- Prefer small, focused widgets and repository methods over large cross-layer changes.
- Preserve existing fake repositories in tests when adding UI behavior.
- Add or update widget tests for user-facing navigation, auth, KYC, admin, or purchase-flow changes.
- Use `const` constructors where Flutter lints expect them.
- Do not commit generated build output from `build/`, `.dart_tool/`, emulator logs, or `node_modules/`.

## Security and Data Rules

- Keep secrets out of source control.
- Do not hardcode production Firebase credentials beyond generated public Firebase client options.
- Review `firestore.rules` and `storage.rules` when adding new Firestore collections, Storage paths, or client-side data access.
- Prefer callable Functions for admin-only mutations and account management.
- Validate callable Function payloads server-side with explicit type checks.

## Before Finishing Work

Run the checks that match the change:

- Flutter UI/domain changes: `flutter analyze` and `flutter test`
- Cloud Functions changes: `npm --prefix functions run build` and `npm --prefix functions run lint`
- Firebase rule changes: run the relevant emulator flow or Firebase rules tests if available
- Asset-only changes: verify the affected screen renders and references the correct asset path

If a check cannot be run locally, report the reason clearly.

## Git Hygiene

- The worktree may contain user changes. Do not revert or overwrite changes you did not make.
- Keep edits scoped to the requested task.
- Do not run destructive commands such as `git reset --hard` or `git checkout --` unless the user explicitly requests them.
- Leave unrelated modified files alone.
