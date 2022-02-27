import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/bottom_nav_bar.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  static String routeName = "/order_detail";

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 380.0,
              height: 100.0,
              child: Card(
                  elevation: 5.0,
                  shadowColor: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Order ID - 1234", style: TextStyle(fontSize: 18)),
                        Text("Order Date - 20/02/2022",
                            style: TextStyle(fontSize: 18)),
                        Text("Status - Done", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              child: Card(
                  elevation: 5.0,
                  shadowColor: Colors.blueGrey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.28,
                            maxHeight: MediaQuery.of(context).size.width * 0.28,
                          ),
                          child: Image.network(
                              'https://picsum.photos/250?image=9',
                              fit: BoxFit.fill),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Laptop Dell",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Divider(),
                          Text(
                            "Quantity: 1",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Price: 10,000,000 VND",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
              width: 380.0,
              height: 150.0,
              child: Card(
                  elevation: 5.0,
                  shadowColor: Colors.blueGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Detail",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      const Divider(
                        thickness: 1.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Total Price: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                  Text("10,000,000 VND",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Total Quantity: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                  Text("1",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
