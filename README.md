# Herafi (حِرفي)

Herafi is a Flutter app that connects people with local craftsmen (حرفيين). Users can search for craftsmen by job, view their profiles, and rate and review them.

## Features

- Sign up and sign in with Firebase Authentication
- Browse job categories and search for craftsmen
- Craftsman profiles with job titles, average rating, and reviews
- Rate and review craftsmen (one review per user)
- Edit your profile and upload profile photos

## Tech Stack

- **Flutter / Dart** for the UI
- **Firebase Authentication** for accounts
- **Cloud Firestore** for profiles, ratings, and reviews
- **Supabase Storage** for profile images
- **flutter_bloc** for state management
- **go_router** for navigation
- **get_it** for dependency injection

## Getting Started

### Prerequisites

- Flutter SDK (Dart `^3.10.4`)
- A Firebase project
- A Supabase project

### Setup

1. Clone the repository and install dependencies:

   ```bash
   git clone https://github.com/AbdelazizMohamed-GitHub/Herafi.git
   cd Herafi
   flutter pub get
   ```

2. **Firebase:** The config is included in `lib/firebase_options.dart`. To use your own Firebase project, run `flutterfire configure`, then enable Email/Phone and Google sign-in in Authentication and create a Cloud Firestore database.

3. **Supabase:** Create a **public** storage bucket named `users`. Then create `lib/app/utils/app_keys.dart` (this file is git-ignored):

   ```dart
   class AppKeys {
     static const String supbaseUrl = 'https://your-project.supabase.co';
     static const String supbaseApiKey = 'your-publishable-key';
   }
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── app/          # DI, routing, theme, shared models
├── core/         # Services (Auth, Firestore, Supabase) and shared widgets
├── features/     # auth, home, profile, welcome (data / domain / presentation)
├── firebase_options.dart
└── main.dart
```

## Contributing

Contributions are welcome. Please open an issue first to discuss what you would like to change, then submit a pull request.

## License

[Add license]
