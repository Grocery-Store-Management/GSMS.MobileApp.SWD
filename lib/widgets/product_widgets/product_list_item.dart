import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

import '../../blocs/product/product_bloc.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({Key? key, required this.product, required this.apiProvider, required this.cateName, required this.details}) : super(key: key);

  final Product product;
  final String cateName;
  final Details details;
  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              child: Card(
                  elevation: 5.0,
                  shadowColor: Colors.blueGrey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.28,
                            maxHeight: MediaQuery.of(context).size.width * 0.28,
                          ),
                          child: Image.network('${product.imageUrl}',
                              fit: BoxFit.fill),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${product.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1.5,
                            ),
                            Text(
                              "Category: $cateName",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Price: ${details.price}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Quantity: ${details.quantity}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}