import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FirebaseProvider {

  Future<void> firebasePoop() async {
    // Initialize the Firebase app
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'GSM Mobile',
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAldJXM2refr3KFIh0qddgtdl_0ts-y14k',
        appId: '1:835304842718:android:b49ddc1e1d5c5bd92de94f',
        messagingSenderId: '835304842718',
        projectId: 'gsms-41f9a',
      ),
    );

    // Method for handling background notification
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

