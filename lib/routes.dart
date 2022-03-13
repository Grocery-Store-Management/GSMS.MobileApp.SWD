import 'package:flutter/material.dart';

import 'package:gsms_mobileapp_swd/screens/home_screen/home.dart';
import 'package:gsms_mobileapp_swd/screens/order_screen/order.dart';
import 'package:gsms_mobileapp_swd/screens/product_screen/product.dart';
import 'package:gsms_mobileapp_swd/screens/notification_screen/notification_list.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  ProductScreen.routeName: (context) => const ProductScreen(),
  NotificationList.routeName: (context) => const NotificationList(),
};
