import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${product.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Text(
                            "Atomic Price: ${product.atomicPrice} VNĐ",
                            style: TextStyle(
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
    );
  }
}