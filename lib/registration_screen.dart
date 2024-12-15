import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RegistrationScreen extends StatelessWidget {
  final String taskId;
  final Map positions;  // Accept the positions data

  RegistrationScreen({required this.taskId, required this.positions});  // Update constructor

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final contactController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Register for Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User name input field
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            // User contact input field
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),

            // Display available positions
            Expanded(
              child: ListView.builder(
                itemCount: positions.length,
                itemBuilder: (context, index) {
                  final position = positions.keys.elementAt(index);
                  final positionData = positions[position];
                  return Card(
                    child: ListTile(
                      title: Text(position), // Position name
                      subtitle: Text('Volunteers: ${positionData['volunteersRegistered']}/${positionData['volunteersRequired']}'),
                      trailing: ElevatedButton(
                        onPressed: positionData['volunteersRegistered'] < positionData['volunteersRequired']
                            ? () {
                          // Register the user for this position
                          _registerForPosition(context, position);
                        }
                            : null,
                        child: Text('Register'),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Submit button to save name and contact
            ElevatedButton(
              onPressed: () {
                final DatabaseReference _regRef = FirebaseDatabase.instance.ref('registrations');
                _regRef.push().set({
                  'taskId': taskId,
                  'name': nameController.text,
                  'contact': contactController.text,
                });

                // Navigate back after successful registration
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully registered')));
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle registration for a selected position
  void _registerForPosition(BuildContext context, String position) {
    final positionRef = FirebaseDatabase.instance.ref('tasks/$taskId/positions/$position');

    positionRef.get().then((snapshot) {
      // Check if the snapshot is valid and cast it to a Map<String, dynamic>
      if (snapshot.exists) {
        final positionData = Map<String, dynamic>.from(snapshot.value as Map);
        int currentCount = positionData['volunteersRegistered'] ?? 0;

        // Update the volunteersRegistered count
        positionRef.update({
          'volunteersRegistered': currentCount + 1,
        }).then((_) {
          // Navigate back after successful registration
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully registered for $position')));
          Navigator.pop(context);
        }).catchError((error) {
          print("Failed to register: $error");
        });
      }
    });
  }
}
