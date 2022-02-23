import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gsms_mobileapp_swd/widgets/home_item_card.dart';

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
              HomeItemCard(
                cardIcon: Icon(Icons.shopping_cart_outlined),
                cardName: 'Order',
                amount: 0,
                routeName: '/order_list',
              ),
              HomeItemCard(
                cardIcon: Icon(Icons.grid_view),
                cardName: 'Product',
                amount: 0,
                routeName: '/',
              ),
              HomeItemCard(
                cardIcon: Icon(Icons.emoji_emotions_outlined),
                cardName: 'Customer',
                amount: 0,
                routeName: '/',
              ),
              HomeItemCard(
                cardIcon: Icon(Icons.people_alt_outlined),
                cardName: 'Employee',
                amount: 0,
                routeName: '/',
              ),
              HomeItemCard(
                cardIcon: Icon(Icons.remove_shopping_cart_outlined),
                cardName: 'Sold out',
                amount: 0,
                routeName: '/',
              ),
              HomeItemCard(
                cardIcon: Icon(Icons.trending_down_outlined),
                cardName: 'Low in Stock',
                amount: 0,
                routeName: '/',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 300,
                maxWidth: 100,
              ),
              child: Card(
                elevation: 5,
                shadowColor: Colors.blueGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        "Product Sales",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                              onPressed: (){},
                              child: Text("Day")
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                              onPressed: (){},
                              child: Text("Month")
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                              onPressed: (){},
                              child: Text("Year")
                          ),
                        ),
                      ],
                    ),
                    SalesChart()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
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

class SalesChart extends StatefulWidget {
  const SalesChart({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesChart> createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  @override
  Widget build(BuildContext context) {
    return Text("Chart Zone");
  }
}
