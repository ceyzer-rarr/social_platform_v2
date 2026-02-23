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
- [Project Architecture](#project-architecture)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Dependencies](#dependencies)
- [Folder Structure Details](#folder-structure-details)
- [API Endpoints](#api-endpoints)
- [Routes & Navigation](#routes--navigation)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Building & Deployment](#building--deployment)
- [Troubleshooting](#troubleshooting)

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

---

## ✨ Features

### 🔐 **Authentication Module**
- **User Registration:** Create new accounts with email validation
- **Login System:** Secure login with email and password
- **OTP Verification:** Two-factor authentication for account security
- **Resend OTP:** Option to request new OTP if not received
- **Logout:** Secure logout functionality
- **Password Management:** Secure credential handling

### 👤 **User Profile Management**
- **View Profile:** Display user information and statistics
- **Update Profile:** Edit name, bio, avatar/profile picture
- **Account Settings:** Manage account preferences
- **Delete Account:** Permanent account removal with data cleanup
- **Profile Statistics:** View post count, followers, engagement metrics

### 🖼️ **Social Feed & Posts**
- **Create Posts:** Upload photos with captions and descriptions
- **View Feed:** Browse posts from all users in chronological order
- **Like/Unlike Posts:** Engage with content through reactions
- **Post Details:** View detailed post information and statistics
- **User Posts:** Filter and view user-specific posts

### 🔔 **Notifications**
- **Push Notifications:** Receive alerts for likes and interactions
- **Notification History:** View all past notifications
- **Notification Center:** Centralized notification management
- **Real-time Updates:** Instant notification delivery

### 🔑 **Additional Features**
- **Search Functionality:** Find users and posts
- **User Relationships:** Follow/Unfollow functionality
- **Content Moderation:** Filter and manage user-generated content

---

## 🏗️ Project Architecture

The project follows **Clean Architecture** with **MVVM** (Model-View-ViewModel) and **Repository Pattern**:

```
┌─────────────────────────────────────────┐
│          Presentation Layer             │
│    (Views, Controllers, Bindings)       │
└─────────────────────────────────────────┘
              ↓ (GetX State Management)
┌─────────────────────────────────────────┐
│       Domain Layer                      │
│    (Use Cases, Entities, Repository)    │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│         Data Layer                      │
│    (Models, Services, Data Sources)     │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│      Laravel REST API                   │
│   (Authentication, Posts, Users,        │
│    Notifications, Storage)               │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│         MySQL Database                  │
│   (User Data, Posts, Notifications)     │
└─────────────────────────────────────────┘
```

### Architecture Benefits:
- **Separation of Concerns:** Each layer has distinct responsibilities
- **Testability:** Easy to unit test individual components
- **Maintainability:** Clear code organization and structure
- **Scalability:** Simple to add new features without affecting existing code
- **Reusability:** Components can be reused across the application

---

## 📁 Project Structure

```
social_platform_app/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── firebase_options.dart        # Firebase configuration
│   │
│   ├── core/                        # Core utilities & constants
│   │   ├── constants/               # App constants (colors, strings, etc.)
│   │   ├── network/                 # API client & networking utilities
│   │   ├── utils/                   # Helper functions & utilities
│   │   └── widgets/                 # Reusable UI widgets
│   │
│   ├── features/                    # Feature modules
│   │   ├── auth/                    # Authentication feature
│   │   │   ├── bindings/            # GetX bindings & dependency injection
│   │   │   ├── controllers/         # Auth controllers & business logic
│   │   │   ├── services/            # Auth services
│   │   │   └── views/               # Auth UI screens
│   │   │
│   │   ├── home/                    # Home/Feed feature
│   │   ├── main/                    # Main navigation wrapper
│   │   ├── post/                    # Post creation & management
│   │   ├── profile/                 # User profile feature
│   │   └── notifications/           # Notifications feature
│   │
│   └── routes/                      # App routing
│       ├── app_pages.dart           # Route definitions
│       └── app_routes.dart          # Route constants
│
├── android/                         # Android-specific code
├── ios/                             # iOS-specific code
├── web/                             # Web-specific code
├── macos/                           # macOS-specific code
├── windows/                         # Windows-specific code
├── linux/                           # Linux-specific code
├── test/                            # Unit & widget tests
├── pubspec.yaml                     # Flutter dependencies
├── analysis_options.yaml            # Dart analysis rules
├── firebase.json                    # Firebase configuration
└── README.md                        # This file
```

---

## 📦 Prerequisites

Before running the app, ensure you have the following installed:

### 1. **Flutter & Dart**
   - [Install Flutter](https://docs.flutter.dev/get-started/install) (Stable channel recommended)
   - Verify installation:
     ```bash
     flutter --version
     dart --version
     ```

### 2. **IDE / Code Editor**
   - Android Studio (recommended for Android development)
   - VS Code with Flutter extension
   - IntelliJ IDEA with Flutter plugin

### 3. **Development Devices/Emulators**
   - **Android:** Android emulator or physical device (API 21+)
   - **iOS:** iOS simulator or iPhone (requires macOS, iOS 11+)
   - **Optional:** Physical device for testing

### 4. **Backend Services**
   - **Laravel API Server:** Backend REST API with following capabilities:
     - Authentication API (register, login, OTP verification)
     - Post management endpoints (CRUD operations)
     - User management endpoints (profile, settings)
     - Notification delivery system
   - **Database:** MySQL/MariaDB for data persistence
   - **API Base URL:** Configure in your Flutter app (e.g., `http://localhost:8000/api`)

### 5. **System Requirements**
   - Windows/macOS/Linux development machine
   - At least 4GB RAM (8GB recommended)
   - 5GB+ free disk space
   - Git for version control

---

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
  static const String baseUrl = 'http://your-laravel-api.com/api';
  // For Android emulator: http://10.0.2.2:8000/api
  // For iOS simulator: http://localhost:8000/api
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

---

## 📂 Folder Structure Details

### **lib/core/constants/**
Contains application-wide constants:
- `app_colors.dart` - Color palette definitions
- `app_strings.dart` - UI text strings
- `app_dimensions.dart` - Spacing, sizing constants

### **lib/core/network/**
Network layer for API communication:
- `api_client.dart` - HTTP client wrapper with common headers and error handling

### **lib/core/utils/**
Utility functions:
- `validators.dart` - Input validation logic
- `helper_functions.dart` - Reusable helper methods
- `date_formatter.dart` - Date/time formatting

### **lib/core/widgets/**
Reusable UI components:
- `custom_button.dart` - Custom button widget
- `custom_text_field.dart` - Styled text input
- `loading_dialog.dart` - Loading indicator
- `error_widget.dart` - Error display component

### **lib/features/auth/**
Authentication feature module:
- **controllers/** - `AuthController` handles login, registration, OTP verification
- **services/** - `AuthService` communicates with backend API
- **views/** - Login, Register, OTP verification screens
- **bindings/** - GetX dependency injection setup

### **lib/features/home/**
Feed display feature:
- Display posts from all users
- Real-time feed updates
- Pull-to-refresh functionality

### **lib/features/post/**
Post management feature:
- Create new posts with images
- Edit and delete posts
- Post validation

### **lib/features/profile/**
User profile feature:
- Display user information
- Edit profile details
- View user posts
- Account settings

### **lib/features/notifications/**
Notifications feature:
- Display notification history
- Real-time notification updates
- Notification filtering

---

## 🔌 API Endpoints

### **Base URL**
```
http://your-laravel-api.com/api
```

### **Authentication Endpoints**
```
POST   /auth/register           # User registration
POST   /auth/login              # User login
POST   /auth/verify-otp         # OTP verification
POST   /auth/resend-otp         # Resend OTP code
POST   /auth/logout             # User logout
GET    /auth/profile            # Get current user profile
```

### **Post Endpoints**
```
GET    /posts                   # Get all posts (paginated)
POST   /posts                   # Create new post (with image)
GET    /posts/:id               # Get specific post details
PUT    /posts/:id               # Update post
DELETE /posts/:id               # Delete post
POST   /posts/:id/like          # Like a post
DELETE /posts/:id/like          # Unlike a post
GET    /posts/user/:userId      # Get posts by user
```

### **User Endpoints**
```
GET    /users/:id               # Get user profile
PUT    /users/:id               # Update user profile
DELETE /users/:id               # Delete user account
GET    /users/:id/posts         # Get user posts
GET    /users/search            # Search users
```

### **Notification Endpoints**
```
GET    /notifications           # Get all notifications
POST   /notifications/mark-read # Mark notification as read
DELETE /notifications/:id       # Delete notification
```

### **Response Format (JSON)**
```json
{
  "success": true,
  "message": "Operation successful",
  "data": {},
  "errors": null
}
```

---

## 🗺️ Routes & Navigation

The app uses **GetX routing** with named routes defined in `lib/routes/app_routes.dart`:

| Route | Purpose | Requires Auth |
|-------|---------|---------------|
| `/welcome` | Welcome/Splash screen | No |
| `/login` | User login | No |
| `/register` | User registration | No |
| `/otp-verify` | OTP verification | No |
| `/home` | Main feed (home screen) | Yes |
| `/post-create` | Create new post | Yes |
| `/post-detail/:id` | Post details | Yes |
| `/profile/:userId` | User profile | Yes |
| `/profile-edit` | Edit own profile | Yes |
| `/notifications` | Notifications page | Yes |

---

## 🎮 Getting Started

### First Time Setup:
1. **Create Account:** Launch app → Register → Enter email/password → Verify OTP
2. **Complete Profile:** Add profile picture and bio
3. **Explore Feed:** View posts from other users
4. **Create Post:** Tap "Create" → Select image → Add caption → Share
5. **Interact:** Like posts, follow users, check notifications

### Key User Flows:

**Login Flow:**
```
Splash → Welcome Screen → Login Screen → Home Feed
                      ↓
                   Register → OTP Verification
```

**Post Creation Flow:**
```
Home → Create Post → Select Image → Add Caption → Preview → Confirm → Home
```

**Profile Management Flow:**
```
Home → Profile → Edit Profile → Update Details → Save → Back to Profile
```

---

## 🛠️ Development Workflow

### Adding New Feature:
1. Create new folder in `lib/features/`
2. Create subdirectories: `models/`, `controllers/`, `services/`, `views/`
3. Implement controller with GetX:
   ```dart
   class MyFeatureController extends GetxController {
     var myVariable = ''.obs;  // Observable variable
     
     void updateVariable(String value) {
       myVariable.value = value;
     }
   }
   ```
4. Add binding for dependency injection
5. Add routes in `app_pages.dart`
6. Create UI using `GetBuilder` or `Obx` widgets

### GetX State Management Example:
```dart
// Controller
class CounterController extends GetxController {
  var count = 0.obs;
  void increment() => count++;
  void decrement() => count--;
}

// Binding
class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounterController>(() => CounterController());
  }
}

// View
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CounterController>();
    return Obx(() => Text('Count: ${controller.count}'));
  }
}
```

### API Call Example:
```dart
Future<void> fetchPosts() async {
  try {
    isLoading.value = true;
    final response = await http.get(Uri.parse('$BASE_URL/api/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      posts.assignAll(data.map((e) => Post.fromJson(e)));
    }
  } catch (e) {
    errorMessage.value = 'Error: $e';
  } finally {
    isLoading.value = false;
  }
}
```

---

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

## 🐛 Troubleshooting

### Common Issues:

**Issue:** `Flutter: No device connected`
```bash
Solution: flutter devices
          # Ensure emulator is started
          # adb devices (for Android)
```

**Issue:** `Connection refused to Laravel API`
```bash
Solution: - Verify Laravel server is running
          - Check API base URL configuration
          - For Android emulator: Use 10.0.2.2 instead of localhost
          - For iOS simulator: Use localhost or your machine IP
          - Example: http://10.0.2.2:8000/api
```

**Issue:** `Image picker not working`
```bash
Solution: - Check app permissions (Android/iOS)
          - Add permissions in AndroidManifest.xml
          - Add permissions in Info.plist (iOS)
```

**Issue:** `OTP verification failing`
```bash
Solution: - Verify OTP is being generated on Laravel backend
          - Check OTP expiration time
          - Ensure email sending is configured on Laravel
```

**Issue:** `Post upload fails with 413 error`
```bash
Solution: - Increase max file upload size in Laravel config
          - Compress images before upload
          - Check nginx.conf max_body_size setting
```

**Issue:** `Authentication token expired`
```bash
Solution: - Implement token refresh mechanism
          - Store refresh token securely
          - Auto logout if token is invalid
```

**Issue:** `GetX controller not found`
```bash
Solution: - Ensure binding is properly registered
          - Check route configuration
          - Verify GetPage includes binding
```

**Issue:** `CORS errors when calling API`
```bash
Solution: - Enable CORS in Laravel middleware
          - Add proper headers: Access-Control-Allow-Origin
          - Install and configure laravel-cors package
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

## 👨‍💻 Technical Stack Summary

| Layer | Technology |
|-------|-----------|
| **Frontend Framework** | Flutter (Dart) |
| **State Management** | GetX |
| **Networking** | HTTP Client |
| **Authentication** | Email/Password + OTP (via Laravel API) |
| **Backend** | Laravel REST API |
| **Database** | MySQL/MariaDB |
| **Architecture** | Clean Architecture + MVVM |
| **Routing** | GetX Named Routes |
| **Dependency Injection** | GetX Bindings |
| **Image Handling** | Image Picker + HTTP multipart upload |

---

## 📞 Support & Contacts

For issues, questions, or contributions:
- Create an issue in the repository
- Contact the development team
- Refer to Flutter documentation: https://docs.flutter.dev

---

## 📜 License

This project is proprietary and confidential.

---

**Last Updated:** February 2026  
**Project Status:** In Development


---

## Project Setup


   ```bash
   flutter pub get
   flutter run
