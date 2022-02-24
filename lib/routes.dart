import 'package:flutter/material.dart';

import 'package:gsms_mobileapp_swd/screens/home_screen/home.dart';
import 'package:gsms_mobileapp_swd/screens/order_screen/order.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  OrderListScreen.routeName: (context) => const OrderListScreen(),
};