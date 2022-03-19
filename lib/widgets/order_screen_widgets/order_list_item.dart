import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/import_order/import_order_bloc.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/screens/order_detail_screen/order_detail.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

// This is the type used by the popup menu below.
enum Options { edit, delete }

class OrderListItem extends StatelessWidget {
  const OrderListItem(
      {Key? key, required this.order, required this.apiProvider})
      : super(key: key);

  final ImportOrder order;
  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
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
          isThreeLine: true,
          leading: const Icon(Icons.shopping_basket, size: 30),
          title: Text('${order.name}'),
          subtitle: Text(
              'Created Date: ${order.createdDate?.substring(0, 10)}\n'
              'Status: ${(order.isDeleted != null) ? 'Not Deleted' : 'Deleted'}'),
          trailing: PopupMenuButton<Options>(
            icon: const Icon(Icons.more_vert),
            onSelected: (Options result) {
              if (result == Options.edit) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const EditStatusDialog();
                  },
                );
              } else if (result == Options.delete) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (_) => ImportOrderBloc(apiProvider: apiProvider),
                      child: ConfirmDialog(deleteId: order.id),
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              const PopupMenuItem<Options>(
                value: Options.edit,
                child: Text('Edit Status'),
              ),
              const PopupMenuItem<Options>(
                value: Options.delete,
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key, required this.deleteId}) : super(key: key);

  final String? deleteId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Do you want to delete this order?',
          style: TextStyle(fontSize: 18)),
      content: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              child: const Text('Yes'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {
                // TODO: Call delete api
                context
                    .read<ImportOrderBloc>()
                    .add(DeleteEvent(deleteId: deleteId));
              },
            ),
            ElevatedButton(
              child: const Text('Cancel'),
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditStatusDialog extends StatefulWidget {
  const EditStatusDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<EditStatusDialog> createState() => _EditStatusDialogState();
}

class _EditStatusDialogState extends State<EditStatusDialog> {
  String dropdownValue = 'Available';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Status'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DropdownButton<String>(
            value: dropdownValue, // default value
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Available', 'Unavailable']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: () {
              //TODO: Call put api to update Order
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
