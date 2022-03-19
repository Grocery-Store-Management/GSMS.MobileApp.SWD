import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gsms_mobileapp_swd/screens/home_screen/home.dart';
import 'package:gsms_mobileapp_swd/services/firebase_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import './routes.dart';
import 'bloc_observer.dart';

Future<void> main() async {
  // Initialize the Firebase app
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    name: 'GSM Mobile',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAldJXM2refr3KFIh0qddgtdl_0ts-y14k',
      appId: '1:835304842718:android:b49ddc1e1d5c5bd92de94f',
      messagingSenderId: '835304842718',
      projectId: 'gsms-41f9a',
    ),
  );

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initialization() async {
    var _initialzationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var _initializationSettings = InitializationSettings(android: _initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(_initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                // TODO add a proper drawable resource to android, for now using
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title.toString()),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(notification.body.toString())],
                ),
              ),
            );
          },
        );
      }
    });

    await FirebaseMessaging.instance.getToken();
    // Remove splash screen when done initializing firebase
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GSM Admin',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
      routes: routes,
    );
  }
}
