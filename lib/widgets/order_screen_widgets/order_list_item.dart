import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  final ImportOrder order;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${order.name}', style: textTheme.caption),
        title: Text('${order.name}'),
        isThreeLine: true,
        subtitle: Text('${order.name}'),
        dense: true,
      ),
    );
  }
}
