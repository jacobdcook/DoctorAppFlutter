# Electronic Medical Records App

This is a mobile application aimed at providing an electronic medical records solution for healthcare providers in Africa and Asia. The app allows doctors, nurses, and other medical staff to manage patient records, schedule appointments, track medical conditions and prescriptions, and more.

## Anticipated Features

- User authentication for doctors/medical staff
- Patient registration and profile management
- Family relationship tracking for patients
- Appointment scheduling
- Medical data management (conditions, medications, test results)
- Prescription management
- Reminders and notifications

## Technologies Used

- Flutter for cross-platform mobile app development
- Firebase for user authentication and Firestore database
- Other potential technologies: MongoDB, Node.js, Express.js

## Getting Started

These instructions will help you set up the project on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK installed ([instructions](https://flutter.dev/docs/get-started/install))
- Android Studio or Xcode for running the app
- Firebase account created

### Installation

1. Clone the repo: `git clone https://github.com/your-username/electronic-medical-records-app.git`
2. Retrieve packages: `flutter pub get`
3. Set up Firebase
   - Create a new Firebase project
   - Enable Authentication and Firestore database
   - Update `firebase_options.dart` file with your project config
4. Run the app:
   - For iOS: `flutter run` (make sure to open the project in Xcode first)
   - For Android: `flutter run` (make sure to have an Android emulator running or a device connected)
