import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/home_widgets/home_item_grid.dart';
import 'package:gsms_mobileapp_swd/widgets/home_widgets/home_product_sales.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSM Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_power),
            onPressed: () {
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
            ProductSales(),
          ],
        ),
        onRefresh: () async  {

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
