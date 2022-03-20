import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/screens/order.dart';
import 'package:gsms_mobileapp_swd/screens/product.dart';
import 'package:gsms_mobileapp_swd/screens/notification_list.dart';

final Map<String, WidgetBuilder> routes = {
  OrderScreen.routeName: (context) => const OrderScreen(),
  ProductScreen.routeName: (context) => const ProductScreen(),
  NotificationList.routeName: (context) => const NotificationList(),
};
