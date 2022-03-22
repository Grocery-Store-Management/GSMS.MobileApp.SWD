import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/home_widgets/home_item_grid.dart';
import 'package:gsms_mobileapp_swd/widgets/home_widgets/home_product_sales.dart';
import 'package:gsms_mobileapp_swd/resources/auth_methods.dart';
import 'package:gsms_mobileapp_swd/screens/history_meeting_screen.dart';
import 'package:gsms_mobileapp_swd/resources/jitsi_meet_methods.dart';
import 'package:gsms_mobileapp_swd/screens/meeting_screen.dart';
import 'package:gsms_mobileapp_swd/utils/colors.dart';
import 'package:gsms_mobileapp_swd/widgets/custom_button.dart';

import '../widgets/home_meeting_button.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
createNewMeeting() async {
  var random = Random();
  String roomName = (random.nextInt(10000000) + 10000000).toString();
  _jitsiMeetMethods.createMeeting(
      roomName: roomName, isAudioMuted: true, isVideoMuted: true);
}

joinMeeting(BuildContext context) {
  Navigator.pushNamed(context, '/video-call');
}

class _HomeScreenState extends State<HomeScreen> {
  // int _page = 0;
  //
  // onPageChanged(int page) {
  //   setState(() {
  //     _page = page;
  //   });
  // }

  // List<Widget> pages = [
  //   RefreshIndicator(
  //     child: ListView(
  //       physics: const AlwaysScrollableScrollPhysics(),
  //       children: <Widget>[
  //         HomeItemGrid(),
  //         ProductSales(),
  //       ],
  //     ),
  //     onRefresh: () async {},
  //   ),
  //   MeetingScreen(),
  //   const HistoryMeetingScreen(),
  //   //const Text('Contacts'),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSM Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_power),
            onPressed: () {
              AuthMethods().signOut();
              Navigator.pushNamed(context, '/login');
              // TODO: When press show an alert to ask user if they want to log out. Call logout function if Yes
            },
          )
        ],
      ),
      body: RefreshIndicator(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            HomeItemGrid(),
            ProductSales(key: UniqueKey()),
            CustomButton(
                text: 'Join Meeting', onPressed: () => joinMeeting(context)),
          ],
        ),
        onRefresh: () async {
          setState(() {});
        },
      ),
    );
  }
}


// class NotificationBadge extends StatelessWidget {
//   final int totalNotifications;
//
//   const NotificationBadge({required this.totalNotifications});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40.0,
//       height: 40.0,
//       decoration: const BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             '$totalNotifications',
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
