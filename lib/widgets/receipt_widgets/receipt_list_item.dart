import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/receipt.dart';
import 'package:gsms_mobileapp_swd/screens/receipt_detail.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

// This is the type used by the popup menu below.
enum Options { edit, delete }

class ReceiptListItem extends StatelessWidget {
  const ReceiptListItem(
      {Key? key, required this.receipt, required this.apiProvider})
      : super(key: key);

  final Receipt receipt;
  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReceiptDetailScreen(),
                settings: RouteSettings(
                  arguments: receipt.id,
                ),
              ),
            );
          },
          child: ListTile(
            isThreeLine: true,
            leading: const Icon(Icons.note, size: 30),
            title: Text('Receipt from: ${receipt.createdDate?.substring(0, 10)}'),
            subtitle: Text(
                'Status: ${(receipt.isDeleted != null) ? 'Not Deleted' : 'Deleted'}'),
          ),
        ),
      ),
    );
  }
}
