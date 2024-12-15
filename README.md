# Volunteer Management Flutter App

This is a mobile application developed using **Flutter** and **Firebase** for managing volunteer registrations for various events. It allows users to view available tasks, register for them, and track volunteer participation. Admins can add tasks and manage volunteer registrations.

## Features

- **Task Listing**: Displays a list of tasks hosted by various admins.
- **Volunteer Registration**: Users can register for tasks under different positions (e.g., coordinator, event manager, etc.).
- **Real-time Updates**: Uses Firebase Realtime Database for live task updates.
- **Firebase Cloud Messaging**: Sends notifications about new tasks or updates (not fully implemented yet).

## Future Scopes of Development

- **Build Your Own Club**: Allow users to **create their own club** where they can manage and host events.
- **Host Events**: Users will be able to **host events** on their club’s page, making it easy to show upcoming events and recruit volunteers.
- **Volunteer Notifications**: Users will be able to **get notifications** about new events from clubs they are following, making volunteer opportunities more accessible.
- **Event Updates**: Admins will be able to **update events**, and volunteers will receive notifications about changes to the tasks they’ve registered for.
- **Authentication System**: Implement a system for **user authentication** and distinguish between **admin** and **user** roles.

Stay tuned for updates on new releases as we continuously improve and enhance the app!

## Technologies Used

- **Flutter**: A cross-platform framework for building natively compiled applications.
- **Firebase**:
  - Firebase Realtime Database for storing task and user registration data.
  - Firebase Cloud Messaging for push notifications.
- **Android**: Focused development on the Android platform for this project.

## Setup Instructions

### Prerequisites

1. **Flutter**: Ensure you have [Flutter installed](https://flutter.dev/docs/get-started/install).
2. **Firebase**: Set up a Firebase project and enable Firebase Realtime Database and Cloud Messaging.
3. **Android Studio**: Install Android Studio to run the app on an emulator or device.

### Steps to Run Locally

Follow these steps to set up the project on your local machine:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/agneepradeep/A-volunteer-management-Flutter-app.git
   cd A-volunteer-management-Flutter-app
   ```

2. **Install Flutter dependencies**:
   Run the following command to fetch the required Flutter packages:
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Add your Android app to the Firebase project.
   - Download the `google-services.json` file from Firebase and place it in the `android/app/` directory.

4. **Set up Firebase Cloud Messaging (optional for notifications)**:
   - Enable Firebase Cloud Messaging in your Firebase Console.
   - Integrate the notification system by following Firebase documentation.

5. **Run the app**:
   After completing the setup, you can run the app on an Android emulator or physical device:
   ```bash
   flutter run
   ```

### Directory Structure

- **lib/**: Contains the Dart source code for the app.
  - **task_list_screen.dart**: Displays a list of tasks available for registration.
  - **registration_screen.dart**: Handles user registration for tasks.
- **android/**: Contains the Android platform-specific code.
- **firebase_config.dart**: Configuration for Firebase integration (if applicable).

### Firebase Setup

1. **Realtime Database**: 
   - The Firebase Realtime Database stores task and registration data.
   - The structure looks like this:
     ```json
     "tasks": {
       "task_id": {
         "name": "Task Name",
         "description": "Task Description",
         "positions": {
           "coordinator": {
             "volunteersRequired": 5,
             "volunteersRegistered": 0
           },
           ...
         }
       }
     }
     ```

2. **Firebase Cloud Messaging**:
   - Sends notifications to users about new tasks or updates (This part is partially set up).

## APK Distribution

You can download the latest release of the app directly from the **Releases** section of this repository.

1. Go to the [Releases page](https://github.com/agneepradeep/A-volunteer-management-Flutter-app/releases)).
2. Download the **`volunteer_app-release.apk`** file.
3. Install the APK on your Android device.

## Contributions

Feel free to fork this repository and submit a pull request with improvements or bug fixes. Contributions are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Next Steps

- **Enhancements**:
   - Add user authentication using Firebase Auth.
   - Implement a fully functional notification system using Firebase Cloud Messaging.
   - Allow users to create clubs and manage events.
   - Allow users to subscribe to specific admins and get notifications only for relevant events.

- **Publishing**:
   - Once the app is tested, consider publishing it to the **Google Play Store**.

## Final Notes

- This project is still in development. The notifications and some advanced features might be incomplete.
- The app currently focuses on the Android platform, with plans for expanding to iOS, Windows, and other platforms in the future.
