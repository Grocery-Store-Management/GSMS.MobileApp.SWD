import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key? key, required this.orderModel}) : super(key: key);

  final ImportOrder orderModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Card(
            elevation: 5,
            shadowColor: Colors.blueGrey,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.pushNamed(context, "/order_detail");
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('${orderModel.id}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          ),
                          Divider(thickness: 1.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.person),
                                      Text('${orderModel.name}'),
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
                                    children: <Widget>[
                                      Icon(
                                        Icons.widgets,
                                      ),
                                      Text("Quantity"),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.store),
                                      Text('${orderModel.store}'),
                                    ],
                                  ),
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.calendar_today),
                                      Text('${orderModel.createdDate}'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
