import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  static String routeName = '/notification_list';

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Center(
            child: Text('No Notifications.'),
          )
        ],
      )
    );
  }
}
