import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:gsms_mobileapp_swd/screens/home.dart';
import 'package:gsms_mobileapp_swd/screens/order.dart';
import 'package:gsms_mobileapp_swd/screens/product.dart';

import '../routes.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  late BuildContext testContext;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return const <Widget>[
      OrderScreen(),
      HomeScreen(),
      ProductScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: "Order",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blueAccent,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: routes,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: ("Notifications"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: routes,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      hideNavigationBarWhenKeyboardShows: true,
      margin: const EdgeInsets.all(0.0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0.0,
      onWillPop: (context) async {
        await showDialog(
          useSafeArea: true,
          context: context!,
          builder: (context) => Container(
            height: 50.0,
            width: 50.0,
            color: Colors.white,
            child: ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
        return false;
      },
      selectedTabScreenContext: (context) {
        testContext = context!;
      },
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(20.0)),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style17, // Choose the nav bar style with this property
    );
  }
}
