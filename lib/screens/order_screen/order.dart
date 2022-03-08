import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

import 'package:gsms_mobileapp_swd/widgets/bottom_nav_bar.dart';
import 'package:gsms_mobileapp_swd/widgets/order_screen_widgets/order_list.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static String routeName = '/order_screen';

  @override
  State<OrderScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderScreen> {
  final ImportOrderBloc _fetchOrders =
      ImportOrderBloc(apiProvider: ApiProvider());

  @override
  void initState() {
    super.initState();
    _fetchOrders.add(ImportOrderFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => _fetchOrders,
          child: BlocListener<ImportOrderBloc, ImportOrderState>(
            listener: (context, state) {
              if (state is ImportOrderError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: Column(
              children: [
                OrderList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
