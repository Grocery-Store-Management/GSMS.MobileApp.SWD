import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';
import 'package:gsms_mobileapp_swd/widgets/bottom_nav_bar.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order_detail/import_order_detail_bloc.dart';
import 'package:gsms_mobileapp_swd/widgets/bottom_loader.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiProvider apiProvider = ApiProvider();
    final String? orderID =
        ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: BlocProvider(
        create: (_) => ImportOrderDetailBloc(apiProvider: apiProvider)
          ..add(ImportOrderDetailFetched(orderID)),
        child: const OrderDetailList(),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class OrderDetailList extends StatefulWidget {
  const OrderDetailList({Key? key}) : super(key: key);

  @override
  State<OrderDetailList> createState() => _OrderDetailListState();
}

class _OrderDetailListState extends State<OrderDetailList> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportOrderDetailBloc, ImportOrderDetailState>(
      builder: (context, state) {
        switch (state.status) {
          case ImportOrderDetailStatus.failure:
            return const Center(child: Text('Failed to fetch orders'));
          case ImportOrderDetailStatus.success:
            if (state.orderDetail.isEmpty) {
              return const Center(child: Text('No orders'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.orderDetail.length && !state.hasReachedMax
                    ? BottomLoader()
                    : OrderDetailItem(orderDetail: state.orderDetail[index]);
              },
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class OrderDetailItem extends StatelessWidget {
  const OrderDetailItem({
    Key? key, required this.orderDetail
  }) : super(key: key);

  final ImportOrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    children: [
                      Text('Order ID: ${orderDetail.importOrderId}', style: TextStyle(fontSize: 18)),
                      Text("Order Date - 20/02/2022", style: TextStyle(fontSize: 18)),
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
                            Text(
                              "10,000,000 VND",
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
                            Text(
                              "1",
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
    );
  }
}
