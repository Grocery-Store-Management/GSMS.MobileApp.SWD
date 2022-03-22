import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/screens/history_meeting_screen.dart';
import 'package:gsms_mobileapp_swd/screens/meeting_screen.dart';
import 'package:gsms_mobileapp_swd/screens/video_call_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:gsms_mobileapp_swd/screens/home.dart';
<<<<<<< Updated upstream
import 'package:gsms_mobileapp_swd/screens/notification_list.dart';
=======

>>>>>>> Stashed changes
import '../resources/auth_methods.dart';
import '../routes.dart';
import 'login_screen.dart';

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
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return <Widget>[
      HomeScreen(),
      MeetingScreen(),
      VideoCallScreen(),
      HistoryMeetingScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.greenAccent,
        activeColorSecondary: Colors.green,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.blueGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: routes,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.video_call),
        title: "Video Call",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.phone_callback),
        title: "Join Call",
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: "Call History",
        activeColorPrimary: Colors.deepPurpleAccent,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.blueGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthMethods().authChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
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
                ? 10.0
                : kBottomNavigationBarHeight,
            hideNavigationBarWhenKeyboardShows: true,
            margin: const EdgeInsets.only(top: 10.0),
            popActionScreens: PopActionScreensType.all,
            bottomScreenMargin: 55.0,
            selectedTabScreenContext: (context) {
              testContext = context!;
            },
            hideNavigationBar: _hideNavBar,
            decoration: NavBarDecoration(
                colorBehindNavBar: Colors.indigo,
                border: Border.all(color: Colors.grey)),
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
            navBarStyle: NavBarStyle
                .style3, // Choose the nav bar style with this property
          );
        }
        return const LoginScreen();
      },
    );
  }
}
