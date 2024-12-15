import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'registration_screen.dart'; // Import the registration screen

// Handle background notifications
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late FirebaseMessaging _messaging;
  final DatabaseReference _taskRef = FirebaseDatabase.instance.ref('tasks');

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() async {
    _messaging = FirebaseMessaging.instance;

    // Request notification permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Get FCM token
    String? token = await _messaging.getToken();
    print('FCM Token: $token');

    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Display the notification title and body in a dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(message.notification!.title ?? 'No Title'),
              content: Text(message.notification!.body ?? 'No Body'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Tasks'),
      ),
      body: StreamBuilder(
        stream: _taskRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<String, dynamic> tasks =
            Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);

            return ListView(
              children: tasks.entries.map((entry) {
                final task = entry.value;
                final taskId = entry.key;
                final positions = task['positions'] as Map;

                return Card(
                  child: ListTile(
                    title: Text(task['name']),
                    subtitle: Text(task['description']),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to RegistrationScreen with task and positions
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(
                              taskId: taskId,
                              positions: positions,
                            ),
                          ),
                        );
                      },
                      child: Text('Register'),
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('No tasks available.'));
          }
        },
      ),
    );
  }
}
