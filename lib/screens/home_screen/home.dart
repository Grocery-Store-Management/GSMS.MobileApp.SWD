import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/menu_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
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
              MenuCard(
                cardName: 'Product',
                routeName: '/',
              ),
              MenuCard(
                cardName: 'Brand',
                routeName: '/',
              ),
              MenuCard(
                cardName: 'Employee',
                routeName: '/',
              ),
              MenuCard(
                cardName: 'Customer',
                routeName: '/',
              ),
              MenuCard(
                cardName: 'Shop',
                routeName: '/',
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
