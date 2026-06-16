# BrickClub

BrickClub is a Flutter app backed by Firebase. Local development uses the Firebase Emulator Suite for Authentication and Cloud Functions so backend work can be built and tested without touching production data.

## Architecture

- `lib/main.dart` boots Flutter, initializes Firebase, and creates app-level dependencies.
- `lib/src/app/` contains the current BrickClub UI and routing gate.
- `lib/src/core/firebase/` contains Firebase bootstrap, emulator configuration, generated-style Firebase options, and shared backend function clients.
- `lib/src/features/auth/` contains the authentication domain contract and Firebase implementation.
- `functions/src/` contains Firebase Cloud Functions, which are the backend entry points.

Keep Firebase calls behind repositories or core service clients. Widgets should call app/domain abstractions, not Firebase SDKs directly.

## Development Setup

Install the required tools:

```powershell
flutter doctor
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```

Install project dependencies:

```powershell
flutter pub get
npm --prefix functions install
```

Start the Firebase emulators:

```powershell
firebase emulators:start --only auth,functions
```

The emulator UI runs at [http://localhost:4000](http://localhost:4000).

Run the Flutter app in development:

```powershell
flutter run --dart-define=USE_FIREBASE_EMULATORS=true
```

The app defaults to emulators in debug builds. For Android emulator runs it uses `10.0.2.2`; for web, Windows, iOS simulator, and macOS it uses `localhost`.

For a physical device on the same network, pass your machine IP:

```powershell
flutter run --dart-define=USE_FIREBASE_EMULATORS=true --dart-define=FIREBASE_EMULATOR_HOST=192.168.1.20
```

## Authentication

Firebase Authentication is the source of truth for sign-in and account creation. During local development, create test users in the Auth emulator UI or through the app sign-up flow.

Current local defaults in the UI:

- member email: `joshua@brickclub.ug`
- admin email: `admin@brickclub.ug`
- password: `password10`

Admin routing is currently a UI mode only. Production admin access should be backed by Firebase custom claims set from trusted Cloud Functions or an admin-only operational process.

## Cloud Functions

Build and lint functions:

```powershell
npm --prefix functions run build
npm --prefix functions run lint
```

Run only the backend emulators:

```powershell
npm --prefix functions run serve
```

The starter callable function is `getMemberProfile`. Add backend business logic under `functions/src/` and call it from typed clients under `lib/src/core/firebase/`.

## Production Setup

Create or choose the production Firebase project, then run:

```powershell
flutterfire configure
```

Use the production Firebase project ID and select the platforms you plan to ship. Replace the placeholder Firebase options in `lib/src/core/firebase/default_firebase_options.dart` with the generated production values, or adopt the generated `lib/firebase_options.dart` and update `FirebaseBootstrap` to import it.

Before a production build, disable emulators explicitly:

```powershell
flutter build web --dart-define=USE_FIREBASE_EMULATORS=false
flutter build apk --dart-define=USE_FIREBASE_EMULATORS=false
```

Deploy Cloud Functions:

```powershell
firebase use <production-project-id>
firebase deploy --only functions
```

Production checklist:

- Enable the required Firebase Authentication providers in the Firebase Console.
- Configure authorized domains for web sign-in.
- Set custom claims for admin users before exposing admin operations.
- Keep secrets out of source control; use Firebase environment/config or Secret Manager.
- Review Firebase security rules whenever Firestore, Storage, or other Firebase products are added.

## Verification

Run Flutter checks:

```powershell
flutter analyze
flutter test
```

Run Functions checks:

```powershell
npm --prefix functions run build
npm --prefix functions run lint
```
