import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: const Text('GSM Admin'),
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

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person_pin_outlined),
                Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
