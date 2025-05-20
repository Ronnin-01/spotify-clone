# 🎵 Spotify With Flutter

A full-featured **Spotify Clone** built using **Flutter**, **BLoC**, **Clean Architecture**, and **Firebase**. This app demonstrates scalable architecture, dynamic theming, authentication, and real-time audio playback with favorites management.

---

## 🚀 Features

- 🎨 Beautiful UI inspired by Spotify
- 🧱 Clean Architecture & Feature-Based Structure
- 🌗 Light / Dark Theme Toggle with Persistence
- 🔐 Firebase Authentication (Sign in / Sign up)
- ☁️ Upload songs to Firebase Storage
- 🔄 Realtime data using Firestore
- 🎧 Audio Player with BLoC state management
- ❤️ Favorite songs support
- 👤 User Profile with editable info and favorites

---

## 🧱 Tech Stack

### 🖥️ Flutter
- `flutter_bloc` - state management
- `equatable` - value equality
- `get_it` - service locator for DI
- `firebase_auth` - auth
- `cloud_firestore` - real-time DB
- `firebase_storage` - media storage
- `just_audio` - audio playback

### ☁️ Firebase
- Authentication (Email/Password)
- Firestore Database
- Firebase Storage

---

## 🧠 Architecture

- **Feature-Based Structure**
- **Clean Architecture**: Domain → Use Cases → Data → Presentation
- **BLoC Pattern** for business logic separation
- **Service Locator** (`get_it`) for dependency injection

---

## 🛠️ Setup Instructions

### 📦 Prerequisites
- Flutter SDK
- Firebase account
- Android/iOS emulator

### ⚙️ Firebase Setup
1. Add your `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)
2. Enable Email/Password Auth
3. Create Firestore & Storage rules
4. Set up Firebase in Flutter (using `flutterfire` CLI or manual steps)

### ▶️ Run the App
```bash
flutter pub get
flutter run
