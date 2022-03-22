import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/category.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

// This is the type used by the popup menu below.
enum Options { edit, delete }

class CategoryListItem extends StatelessWidget {
  const CategoryListItem(
      {Key? key,
      required this.category,
      required this.apiProvider})
      : super(key: key);

  final Category category;
  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: ListTile(
          isThreeLine: true,
          leading: const Icon(Icons.layers, size: 30),
          title: Text('${category.name}', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Status: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: category.isDeleted! ? 'Is Deleted' : 'Not Deleted', style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
            ],
          ),

          // subtitle: Text('Brand: $brandName\n'
          //    'Created Date: ${category.createdDate?.substring(0, 10)}\n'
          //    'Status: ${(category.isDeleted != null) ? 'Not Deleted' : 'Deleted'}'),
        ),
      ),
    );
  }
}
