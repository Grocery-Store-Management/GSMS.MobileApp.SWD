import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/store.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

// This is the type used by the popup menu below.
enum Options { edit, delete }

class StoreListItem extends StatelessWidget {
  const StoreListItem(
      {Key? key,
      required this.store,
      required this.brandName,
      required this.apiProvider})
      : super(key: key);

  final Store store;
  final String brandName;
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
          leading: const Icon(Icons.store, size: 30),
          title: Text('${store.name}', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Brand: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: brandName, style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Created Date: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: store.createdDate, style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Status: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: store.isDeleted! ? 'Is Deleted' : 'Not Deleted', style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
            ],
          ),

          // subtitle: Text('Brand: $brandName\n'
          //    'Created Date: ${store.createdDate?.substring(0, 10)}\n'
          //    'Status: ${(store.isDeleted != null) ? 'Not Deleted' : 'Deleted'}'),
        ),
      ),
    );
  }
}
