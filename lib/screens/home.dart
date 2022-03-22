import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/home_widgets/home_item_grid.dart';
import 'package:gsms_mobileapp_swd/widgets/home_widgets/home_product_sales.dart';
import 'package:gsms_mobileapp_swd/resources/auth_methods.dart';
import 'package:gsms_mobileapp_swd/screens/history_meeting_screen.dart';
import 'package:gsms_mobileapp_swd/screens/meeting_screen.dart';
import 'package:gsms_mobileapp_swd/utils/colors.dart';
import 'package:gsms_mobileapp_swd/widgets/custom_button.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    RefreshIndicator(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          HomeItemGrid(),
          ProductSales(),
        ],
      ),
      onRefresh: () async {},
    ),
    MeetingScreen(),
    const HistoryMeetingScreen(),
    //const Text('Contacts'),

    CustomButton(text: 'Log Out', onPressed: () => AuthMethods().signOut()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSM Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_power),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
              // TODO: When press show an alert to ask user if they want to log out. Call logout function if Yes
            },
          )
        ],
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.comment_bank,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.comment_bank,
            ),
            label: 'Create & Join',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
            ),
            label: 'Meetings History',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Contacts',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
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
