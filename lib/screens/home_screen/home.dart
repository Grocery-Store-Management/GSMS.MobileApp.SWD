import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:gsms_mobileapp_swd/services/local_notification.dart';

import 'package:gsms_mobileapp_swd/widgets/bottom_nav_bar.dart';
import 'package:gsms_mobileapp_swd/widgets/home_screen_widgets/home_item_grid.dart';
import 'package:gsms_mobileapp_swd/widgets/home_screen_widgets/home_product_sales.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialize(context);
    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });
    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });
    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSM Admin'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Icon(Icons.notifications),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: const <Widget>[
          HomeItemGrid(),
          ProductSales(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
