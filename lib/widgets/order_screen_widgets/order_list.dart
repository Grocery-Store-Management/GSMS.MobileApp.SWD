import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/widgets/loading_indicator.dart';
import 'package:gsms_mobileapp_swd/widgets/message_dialog.dart';
import 'package:gsms_mobileapp_swd/widgets/order_screen_widgets/order_list_item.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order/import_order_bloc.dart';
import 'package:gsms_mobileapp_swd/widgets/bottom_loader.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final _scrollController = ScrollController();
  final List<ImportOrder> _listOrder = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImportOrderBloc, ImportOrderState>(
      listener: (context, state) {
        if (state.orders != null) {
          setState(() {
            _listOrder.addAll(state.orders!);
          });
        }
        if (state is LoadingDelete) {
          Navigator.of(context, rootNavigator: true).pop();
          WidgetsBinding.instance!.addPostFrameCallback(
            (_) => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const LoadingIndicator();
              },
            ),
          );
        }
        if (state is SuccessDelete) {
          Navigator.of(context, rootNavigator: true).pop();
          WidgetsBinding.instance!.addPostFrameCallback(
            (_) => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const MessageDialog(
                    title: "Success", message: "Order has been deleted.");
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return ListView.builder(itemBuilder: (BuildContext context, int index) {
          return index >= state.orders!.length
              ? BottomLoader()
              : OrderListItem(order: state.orders![index]);
        });
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ImportOrderBloc>().add(GetAllEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
