# social_platform_app

A Flutter-based social networking app where users can register, verify their account via OTP, create photo posts with captions, like posts, manage their profile, receive notifications, and more.

---

## Features

- 🔐 **Authentication**
    - Register (sign up)
    - Login
    - OTP verification
    - Resend OTP
    - Logout

- 👤 **User Profile**
    - View profile
    - Update profile information (name, avatar, etc.)
    - Delete account

- 🖼️ **Social Feed**
    - Post photo with caption
    - View posts in feed
    - Like / unlike post

- 🔔 **Notifications**
    - Notification screen to see app-related updates (likes, etc.)

---

## Prerequisites

Before running the app, make sure you have:

- [Flutter](https://docs.flutter.dev/get-started/install) (stable channel) installed
- Android Studio / VS Code / IntelliJ (any Flutter-compatible IDE)
- A device or emulator:
    - Android emulator / physical Android device
    - (Optional) iOS simulator / iPhone (requires macOS)
- Backend API for the social platform:
    - The API should expose endpoints for:
        - Register / Login
        - OTP verify + resend
        - Post CRUD (create/read)
        - Like / unlike
        - Profile update / delete
        - Notifications


---

## Project Setup


   ```bash
   flutter pub get
   flutter run
