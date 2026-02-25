# SocialVibe - Social Platform App

A comprehensive Flutter-based social networking application built with modern architectural patterns and best practices. Users can register, verify accounts via OTP, create and share photo posts with captions, like posts, manage profiles, and receive real-time notifications.

**App Name:** SocialVibe  
**Version:** 1.0.0+1  
**Framework:** Flutter 3.10.7+  
**State Management:** GetX  
**Backend:** Laravel REST API

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [Building & Deployment](#building--deployment)

---

## 🎯 Project Overview

**SocialVibe** is a full-featured social media platform designed to provide users with a seamless experience for connecting, sharing, and engaging with others. The application demonstrates professional-grade Flutter development practices including clean architecture, state management with GetX, HTTP networking, and Firebase integration.

### Key Objectives:
- Provide secure user authentication with OTP verification
- Enable users to create and share visual content
- Facilitate social interaction through likes and engagement
- Maintain user profiles with customizable information
- Deliver real-time notifications for user activities
- Support multiple authentication methods (email, Google Sign-In)


## 🚀 Installation & Setup

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd social_platform_app
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Configure API Base URL
Update the API client configuration in `lib/core/network/api_client.dart`:
```dart
class ApiClient {
  static const String baseUrl = 'https://social-api.hushstackcambodia.site/api';
}
```

### Step 4: Configure Environment
```bash
# Get dependencies again
flutter pub get

# For Android
cd android
./gradlew build

# For iOS (macOS only)
cd ios
pod install
cd ..
```

### Step 5: Run the App
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run on Android emulator
flutter run -d emulator-5554

# Run on iOS simulator
flutter run -d macos
```

---

## 📚 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| **GetX** | ^4.6.6 | State management & routing |
| **http** | ^1.2.0 | HTTP client for API calls to Laravel backend |
| **image_picker** | ^1.0.7 | Image selection from device for posts |
| **font_awesome_flutter** | ^10.7.0 | Font Awesome icons |
| **cupertino_icons** | ^1.0.8 | iOS-style icons |

### Dev Dependencies:
- **flutter_lints:** ^6.0.0 - Lint rules for code quality
- **flutter_test:** SDK - Testing framework


## 📦 Building & Deployment

### Android Build:
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App Bundle for Play Store
flutter build appbundle --release
```

### iOS Build:
```bash
# Build for iOS
flutter build ios --release

# Create IPA file
cd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release -derivedDataPath build -archivePath build/Runner.xcarchive archive
xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath build
```

### Web Build:
```bash
flutter build web --release
```

---

## 📄 Build Information

- **Dart SDK Version:** ^3.10.7
- **Flutter Channel:** stable
- **Minimum Android API:** 21
- **Minimum iOS Version:** 11.0
- **App Version:** 1.0.0
- **Build Number:** 1

---

## Project Setup


   ```bash
   flutter pub get
   flutter run
