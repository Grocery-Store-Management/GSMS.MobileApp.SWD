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
              return OrderDetailItem(
                orderDetail: state.details[index],
                productImage: state.productsImages[index],
              );
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
    Key? key, required this.orderDetail, required this.productImage
  }) : super(key: key);

  final ImportOrderDetail orderDetail;
  final String productImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                            productImage,
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
