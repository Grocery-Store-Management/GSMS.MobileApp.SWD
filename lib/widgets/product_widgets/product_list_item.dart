import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

import '../../blocs/product/product_bloc.dart';
import '../circular_loading.dart';

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
              height: MediaQuery.of(context).size.height * 0.26,
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
                            TextButton(onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmDialog(apiProvider: apiProvider, product: product);
                                  }
                              );
                            }, child: Text('Delete', style: TextStyle(color: Colors.redAccent),))
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

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.apiProvider,
    required this.product,
  }) : super(key: key);

  final ApiProvider apiProvider;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => ProductBloc(apiProvider: apiProvider),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is Loading) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => loadingIndicator(context, "Loading..."));
          } else if (state is Failure) {
            Navigator.of(context, rootNavigator: true).pop(); //close loading
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Error!", 'An error has occurred'));
          } else if (state is DeleteSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); //close loading
            Navigator.of(context).pop(); //close dialog
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Success!", "Product was deleted."));
          }
        },
        builder : (context, state) {
          return AlertDialog(
            title: const Text('Do you want to delete this item?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    context.read<ProductBloc>()
                        .add(DeleteEvent(id: product.id!));
                  },
                  child: const Text('Yes')),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
            ],
          );
        }
      ),
    );
  }
}