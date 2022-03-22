import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order_detail/import_order_detail_bloc.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiProvider apiProvider = ApiProvider();
    final String orderId = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: BlocProvider(
        create: (_) => ImportOrderDetailBloc(apiProvider: apiProvider)..add(GetIdEvent(orderId: orderId)),
        child: const OrderDetailList(),
      ),
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
        if (state is OrderDetailInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderDetailLoaded) {
          return ListView.builder(
            itemCount: state.details.length,
            itemBuilder: (context, index) {
              return OrderDetailItem(orderDetail: state.details[index],);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
// TODO: Fix widget to display info properly
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
                    children: <Widget>[
                      Text("Order Date - 20/02/2022", style: TextStyle(fontSize: 18)),
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
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${orderDetail.name?.replaceRange(20, orderDetail.name?.length, '...')}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          "Quantity: ${orderDetail.quantity}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Price: ${orderDetail.price} VND",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
