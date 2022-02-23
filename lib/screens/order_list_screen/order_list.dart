import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/screens/order_list_screen/widgets/order_list_card.dart';
import 'package:gsms_mobileapp_swd/screens/order_list_screen/widgets/order_date_picker.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  static String routeName = '/order_list';

  @override
  State<OrderListScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderListScreen> {
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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: OrderDatePicker(),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.blueGrey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      OrderListCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


