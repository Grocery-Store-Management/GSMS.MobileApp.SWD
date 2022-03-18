import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/screens/order_detail_screen/order_detail.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  final ImportOrder order;

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 5,
    //   shadowColor: Colors.blueGrey,
    //   child: InkWell(
    //     splashColor: Colors.blue.withAlpha(30),
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const OrderDetailScreen(),
    //           settings: RouteSettings(
    //             arguments: order.id,
    //           ),
    //         ),
    //       );
    //     },
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 150,
    //           child: Container(
    //             padding: const EdgeInsets.all(10.0),
    //             child: Column(
    //               children: <Widget>[
    //                 Row(
    //                   children: <Widget>[
    //                     Text('${order.name}',
    //                         style: const TextStyle(
    //                             fontWeight: FontWeight.bold, fontSize: 12)),
    //                   ],
    //                 ),
    //                 const Divider(thickness: 1.5),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         WrapTextIcon(
    //                           order: order,
    //                           icon: const Icon(Icons.calendar_today),
    //                           label: 'Order Date:  ${order.createdDate?.substring(0, 10)}',
    //                         ),
    //                         WrapTextIcon(
    //                             order: order,
    //                             icon: const Icon(Icons.widgets_outlined),
    //                             label: 'Status:  ${order.isDeleted}')
    //                       ],
    //                     ),
    //                     Column(
    //                       children: [],
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Card(
      elevation: 5,
      shadowColor: Colors.blueGrey,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderDetailScreen(),
                settings: RouteSettings(
                  arguments: order.id,
                ),
              ),
            );
          },
          child: ListTile(
            leading: const Icon(Icons.shopping_basket, size: 30),
            title: Text('${order.name}'),
            subtitle: Text('Create Date: ${order.createdDate?.substring(0, 10)}\n' 'Status: ${(order.isDeleted != null) ? 'Still Up' : 'Is Deleted'}'),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {  },),
            isThreeLine: true,
          ),
        ),
    );
  }
}

class WrapTextIcon extends StatelessWidget {
  const WrapTextIcon({
    Key? key,
    required this.order,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final ImportOrder order;
  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        icon,
        Text(label),
      ],
    );
  }
}
