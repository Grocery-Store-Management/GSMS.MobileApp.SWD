import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/order_widgets/order_list_item.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order/import_order_bloc.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImportOrderBloc, ImportOrderState>(
        listener: (context, state) {
      if (state is OrderError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message!),
          ),
        );
      }
    }, child: BlocBuilder<ImportOrderBloc, ImportOrderState>(
      builder: (context, state) {
        if (state is OrderInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderLoaded) {
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              return OrderListItem(
                order: state.orders[index],
                apiProvider: _apiProvider,
              );
            },
          );
        } else {
          return Container();
        }
      },
    ));
  }
}
