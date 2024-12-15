package com.example.volunteer_app;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

public class MyFirebaseMessagingService extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // Handle the message here
        if (remoteMessage.getNotification() != null) {
            // Handle notification
            String message = remoteMessage.getNotification().getBody();
            System.out.println("Message received: " + message);
        }
    }

    @Override
    public void onNewToken(String token) {
        // Handle the new token if needed
        System.out.println("New token: " + token);
    }
}
