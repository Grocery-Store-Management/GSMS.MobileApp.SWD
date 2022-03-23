import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/brand.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

// This is the type used by the popup menu below.
enum Options { edit, delete }

class BrandListItem extends StatelessWidget {
  const BrandListItem(
      {Key? key, required this.brand, required this.apiProvider})
      : super(key: key);

  final Brand brand;
  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blueGrey,
      child: ListTile(
        isThreeLine: true,
        leading: const Icon(Icons.shop, size: 30),
        title: Text('${brand.name}'),
        subtitle: Text(
            'Created Date: ${brand.createdDate?.substring(0, 10)}\n'
            'Status: ${(brand.isDeleted != null) ? 'Not Deleted' : 'Deleted'}'),
      ),
    );
  }
}
