import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/example.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  static String routeName = '/order_list';

  @override
  State<OrderListScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderListScreen> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              StartDateButton(),
              EndDateButton(),
              ClearDateButton(),
            ],
          ),
          Row(
            children: const <Widget>[
              // TODO: Style OrderItemCard following figma design
              Expanded(
                child: OrderItemCard(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blueGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Itemcard1Widget(),
        ],
      ),
    );
  }
}

class ClearDateButton extends StatelessWidget {
  const ClearDateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
      onPressed: () {
        // TODO: Add clear Start Date and End Date
      },
      child: Icon(Icons.cancel),
    );
  }
}

class EndDateButton extends StatelessWidget {
  const EndDateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
      onPressed: () {
        // TODO: Add showDatePicker function
      },
      child: const Text('End Date'),
    );
  }
}

class StartDateButton extends StatelessWidget {
  const StartDateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
      onPressed: () {
        // TODO: Add showDatePicker function
      },
      child: const Text('Start Date'),
    );
  }
}
