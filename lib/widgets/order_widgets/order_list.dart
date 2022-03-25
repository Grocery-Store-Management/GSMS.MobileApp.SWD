import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/order_widgets/order_list_item.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order/import_order_bloc.dart';

import '../../models/import_order.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final ApiProvider apiProvider = ApiProvider();
  List<ImportOrder> orderList = [];
  int sort = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImportOrderBloc>(
      create: (_) => ImportOrderBloc(apiProvider: apiProvider)..add(GetAllEvent(sort: sort)),
      child: BlocListener<ImportOrderBloc, ImportOrderState>(
          listener: (context, state) {
        if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        }
        if (state is OrderLoaded) {
          setState(() {
            orderList = state.orders;
          });
        }
      }, child: BlocBuilder<ImportOrderBloc, ImportOrderState>(
        builder: (context, state) {
          if (state is OrderInitial) {
            return const Center(child: CircularProgressIndicator());
          } 
          return RefreshIndicator(
            onRefresh: () async{
              context.read<ImportOrderBloc>().add(GetAllEvent(sort: sort));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Sort by Date: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          sort = -1;
                        });
                        context.read<ImportOrderBloc>().add(GetAllEvent(sort: sort));
                      }, child: Text('Newest')),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          sort = 1;
                        });
                        context.read<ImportOrderBloc>().add(GetAllEvent(sort: sort));
                      }, child: Text('Oldest')),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return OrderListItem(
                        order: orderList[index],
                        apiProvider: apiProvider,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
