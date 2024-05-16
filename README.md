# Doctor App Installation Guide

---

## 1. Prerequisites

Before you begin, ensure you have the following installed on your system:

1. **Flutter SDK**: Download and install Flutter SDK from the [official website](https://flutter.dev/docs/get-started/install).
2. **Android Studio**: Install Android Studio which includes Android SDK, Emulator, and other tools.
3. **Xcode (for iOS development)**: Required for building and running the iOS version of the app. Install from the Mac App Store.
4. **VS Code (optional)**: Install Visual Studio Code as the preferred code editor.
5. **Git**: Version control system for cloning the project repository.

---

## 2. Setting Up the Development Environment

### For Windows:

#### Step 1: Install Flutter SDK

1. Follow the instructions for Windows from the [Flutter install guide](https://flutter.dev/docs/get-started/install/windows).

#### Step 2: Install Android Studio

1. Download and install Android Studio from [here](https://developer.android.com/studio).
2. Open Android Studio and go to `File` > `Settings` > `System Settings` > `Android SDK`.
3. Install the latest Android SDK tools and platforms.
4. Set up an Android emulator by going to `AVD Manager` and creating a virtual device.

#### Step 3: Set Environment Variables

1. **Find the Flutter SDK Path:**
   - Locate the Flutter SDK directory. It should contain `flutter` and `bin` directories.

2. **Add Flutter to Path:**
   - Open the **Start Search**, type in **"env"**, and select **"Edit the system environment variables"**.
   - In the **System Properties** window, click on **"Environment Variables"**.
   - Under **"System variables"**, find the **"Path"** variable, and click **"Edit..."**.
   - Click **"New"** and add the full path to the `flutter\bin` directory (e.g., `C:\flutter\bin`).
   - Click **"OK"** to close all dialog boxes.

3. **Add Dart to Path (Optional, if not included with Flutter):**
   - If Dart is installed separately, add the path to the `dart-sdk\bin` directory.

4. **Verify the Setup:**
   - Open a new command prompt and run:
     ```sh
     flutter doctor
     ```

---

### For macOS:

#### Step 1: Install Flutter SDK

1. Follow the instructions for macOS from the [Flutter install guide](https://flutter.dev/docs/get-started/install/macos).

#### Step 2: Install Android Studio

1. Download and install Android Studio from [here](https://developer.android.com/studio).
2. Open Android Studio and go to `Preferences` > `System Settings` > `Android SDK`.
3. Install the latest Android SDK tools and platforms.
4. Set up an Android emulator by going to `AVD Manager` and creating a virtual device.

#### Step 3: Set Up Xcode (macOS only)

1. Install Xcode from the Mac App Store.
2. Open Xcode and go to `Preferences` > `Locations` to set the command-line tools.
3. Install CocoaPods by running `sudo gem install cocoapods` in the terminal.

#### Step 4: Set Environment Variables

1. **Add Flutter to Path:**
   - Open a terminal and run:
     ```sh
     export PATH="$PATH:`pwd`/flutter/bin"
     ```
   - Add the above line to your `~/.bash_profile` or `~/.zshrc` file to make the change permanent.

2. **Add Dart to Path (Optional, if not included with Flutter):**
   - If Dart is installed separately, add the path to the `dart-sdk/bin` directory.

3. **Verify the Setup:**
   - Open a new terminal and run:
     ```sh
     flutter doctor
     ```

---

## 3. Cloning the Project Repository

1. Open a terminal or command prompt.
2. Clone the project repository using Git:
    ```sh
    git clone https://github.com/jacobdcook/DoctorAppFlutter
    cd doctor_app_project
    ```

---

## 4. Setting Up the Project

### Step 1: Install Flutter Dependencies

1. Navigate to the project directory in the terminal:
    ```sh
    cd doctor_app_project
    ```
2. Run the following command to get all the dependencies:
    ```sh
    flutter pub get
    ```

### Step 2: Configure Firebase (if applicable)

1. Follow the instructions to set up Firebase for your Flutter project from the [official guide](https://firebase.flutter.dev/docs/overview).
2. Ensure the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files are properly placed in the project.

---

## 5. Running the App

### For Android:

1. Ensure your Android device or emulator is running.
2. Run the app using the following command:
    ```sh
    flutter run
    ```

### For iOS (macOS only):

1. Open the iOS project in Xcode:
    ```sh
    open ios/Runner.xcworkspace
    ```
2. Select your device or simulator and click the Run button.

---

## 6. Building the APK

1. To build the APK file for Android, run:
    ```sh
    flutter build apk --release
    ```
2. The APK file will be located in `build/app/outputs/flutter-apk/app-release.apk`.

---

## 7. Building the IPA (macOS only)

1. To build the IPA file for iOS, run:
    ```sh
    flutter build ios --release
    ```
2. Open the iOS project in Xcode:
    ```sh
    open ios/Runner.xcworkspace
    ```
3. Select your device and archive the project by going to `Product` > `Archive`.
4. Follow the steps to export the IPA file.

---

## Additional Configuration and Dependencies

- **Firebase Configuration**: Ensure that your Firebase project is properly configured and that all necessary files are included in the project.
- **Third-Party Libraries**: Make sure all third-party libraries are correctly added to the `pubspec.yaml` file and installed using `flutter pub get`.

---

## Support

If you encounter any issues during the installation process, refer to the Flutter [documentation](https://flutter.dev/docs) or seek assistance from the project maintainer.

---

This installation guide provides detailed steps to set up, build, and run the Doctor App on your local machine. Follow each step carefully to ensure a successful setup.
****
