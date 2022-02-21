import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/menu_card.dart';

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
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: const Text('GSM Admin'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          GridView.count(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 3,
            children: const <Widget>[
              MenuCard(
                cardName: 'Order',
                routeName: '/order_list',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
