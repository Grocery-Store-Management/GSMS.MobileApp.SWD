import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gsms_mobileapp_swd/blocs/import_order_bloc.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/widgets/bottom_nav_bar.dart';
import 'package:gsms_mobileapp_swd/widgets/order_screen_widgets/order_list_card.dart';
import 'package:gsms_mobileapp_swd/widgets/order_screen_widgets/order_date_picker.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static String routeName = '/order_screen';

  @override
  State<OrderScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderScreen> {
  final ImportOrderBloc _newBloc = ImportOrderBloc();
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();

  @override
  void initState() {
    _newBloc.add(GetImportOrderList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Column(
        children: [
          OrderDatePicker(),
          BlocProvider(
            create: (_) => _newBloc,
            child: BlocListener<ImportOrderBloc, ImportOrderState>(
                listener: (context, state) {
                  if (state is ImportOrderError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message!),
                      ),
                    );
                  };
                },
              child: BlocBuilder<ImportOrderBloc, ImportOrderState>(
                builder: (context, state) {
                  if (state is ImportOrderInitial) {
                    return _buildLoading();
                  } else if (state is ImportOrderLoading) {
                    return _buildLoading();
                  } else if (state is ImportOrderLoaded) {
                    return _buildListView(context, state.importOrderModel);
                  } else if (state is ImportOrderError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

Widget _buildLoading() => const Center(child: CircularProgressIndicator());

Widget _buildListView(BuildContext context, ImportOrder importOrderModel) {
  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.all(20.0),
    children: const <Widget>[
      OrderListCard(),
    ],
  );
}