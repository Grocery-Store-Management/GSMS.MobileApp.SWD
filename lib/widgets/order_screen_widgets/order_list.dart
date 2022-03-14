import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/widgets/order_screen_widgets/order_list_item.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order_bloc/import_order_bloc.dart';
import 'package:gsms_mobileapp_swd/widgets/bottom_loader.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportOrderBloc, ImportOrderState>(
      builder: (context, state) {
        switch (state.status) {
          case ImportOrderStatus.failure:
            return const Center(child: Text('Failed to fetch orders'));
          case ImportOrderStatus.success:
            if (state.orders.isEmpty) {
              return const Center(child: Text('No orders'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.orders.length && !state.hasReachedMax
                    ? BottomLoader()
                    : OrderListItem(order: state.orders[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.orders.length
                  : state.orders.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
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
    if (_isBottom) context.read<ImportOrderBloc>().add(ImportOrderFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
