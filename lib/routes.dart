import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/screens/brand.dart';
import 'package:gsms_mobileapp_swd/screens/category.dart';
import 'package:gsms_mobileapp_swd/screens/login_screen.dart';
import 'package:gsms_mobileapp_swd/screens/order.dart';
import 'package:gsms_mobileapp_swd/screens/product.dart';
import 'package:gsms_mobileapp_swd/screens/receipt.dart';
import 'package:gsms_mobileapp_swd/screens/store.dart';
import 'package:gsms_mobileapp_swd/screens/video_call_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OrderScreen.routeName: (context) => const OrderScreen(),
  ProductScreen.routeName: (context) => const ProductScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  VideoCallScreen.routeName: (context) => const VideoCallScreen(),
  BrandScreen.routeName: (context) => const BrandScreen(),
  StoreScreen.routeName: (context) => const StoreScreen(),
  ReceiptScreen.routeName: (context) => const ReceiptScreen(),
  CategoryScreen.routeName: (context) => const CategoryScreen(),
};
