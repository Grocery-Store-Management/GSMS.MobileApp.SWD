import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  static String routeName = "/order_list_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}