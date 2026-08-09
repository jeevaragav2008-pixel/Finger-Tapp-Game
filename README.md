# 👆 Finger Tap Game — a fast two-player tapping challenge

> Challenge a friend on one device: tap your side of the screen to claim the play area, build your score, and be the first player to take it all.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Material Design](https://img.shields.io/badge/Material%20Design-757575?logo=materialdesign&logoColor=white)](https://m3.material.io/)

---

## 🚀 Key Features

* **🧑‍🤝‍🧑 Two-player setup**: Enter names for both players before a match so every game has a clear rivalry.

* **👆 Split-screen tapping**: Each player taps their coloured half of the display to push the boundary towards their opponent.

* **📈 Live scoring**: Every tap increases the active player's score by five points, making the winning effort visible.

* **🏁 Clear win condition**: Taking almost the entire screen ends the match immediately and announces the winner.

* **🔄 Instant rematch**: Start over from the result screen to set up another round without restarting the app.

---

## 🛠️ Technology Stack

* **Framework**: [Flutter](https://flutter.dev/) (builds the app for Android, iOS, web, Windows, macOS, and Linux from one codebase)

* **Language**: [Dart](https://dart.dev/) (implements the game state and interface)

* **UI**: [Material Design](https://m3.material.io/) (provides the app's widgets and visual foundation)

* **Quality tools**: [flutter_lints](https://pub.dev/packages/flutter_lints) (supplies recommended static-analysis rules)

---

## 📦 Getting Started

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) with Dart SDK `^3.12.2`

* A device, emulator, or desktop/web target configured for Flutter development

### Local Development

1. **Clone the repository**:

   ```bash
   git clone [repository-url]
   ```

   ```bash
   cd finger_tap_game
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Start the app**:

   ```bash
   flutter run
   ```

   Select a connected target when prompted. The app does not require a local server port.

4. **Run static analysis**:

   ```bash
   flutter analyze
   ```

---

## 🏗️ Production Build & Deployment

### Build an Android APK

```bash
flutter build apk
```

Flutter writes the release APK to `build/app/outputs/flutter-apk/app-release.apk`.

For other supported targets, use the corresponding Flutter build command, such as `flutter build web` or `flutter build windows`.

---

## 📄 License

No license has been specified for this project.
