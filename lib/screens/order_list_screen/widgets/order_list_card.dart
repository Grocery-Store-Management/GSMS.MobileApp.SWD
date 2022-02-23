import 'package:flutter/material.dart';

class OrderListCard extends StatefulWidget {
  const OrderListCard({Key? key}) : super(key: key);

  @override
  _OrderListCardState createState() => _OrderListCardState();
}

class _OrderListCardState extends State<OrderListCard> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator ItemCard - COMPONENT

    return SizedBox(
      height: 150,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const <Widget>[
            OrderTitle(),
            Divider(
              thickness: 1.5,
            ),
            OrderInfoRow(),
          ],
        ),
      ),
    );
  }
}

class OrderTitle extends StatelessWidget {
  const OrderTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          "Order's ID",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        // Status box
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 80.0,
            minHeight: 20.0,
          ),
          child: SizedBox.shrink(
            child: ElevatedButton(
              child: const Text('Status'),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class OrderInfoRow extends StatelessWidget {
  const OrderInfoRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const <Widget>[
                Icon(Icons.person),
                Text("Nguyen Huynh Nhat Minh"),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: const <Widget>[
                Icon(Icons.money),
                Text("Pay amount"),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: const <Widget>[
                Icon(Icons.widgets,),
                Text("Quantity"),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const <Widget>[
                Icon(Icons.phone),
                Text("0916460400"),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const <Widget>[
                Icon(Icons.calendar_today),
                Text("01/09/2022"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}