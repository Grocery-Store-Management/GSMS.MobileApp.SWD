import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/bottom_nav_bar.dart';
import 'package:gsms_mobileapp_swd/widgets/order_screen_widgets/order_list_card.dart';
import 'package:gsms_mobileapp_swd/widgets/order_screen_widgets/order_date_picker.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static String routeName = '/order_screen';

  @override
  State<OrderScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderScreen> {
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: const <Widget>[
          OrderDatePicker(),
          OrderListCard(),
          OrderListCard(),
          OrderListCard(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}