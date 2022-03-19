import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/product/product_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/message_dialog.dart';
import 'package:gsms_mobileapp_swd/widgets/loading_indicator.dart';

class ProductCreateDialog extends StatefulWidget {
  const ProductCreateDialog({Key? key}) : super(key: key);

  @override
  State<ProductCreateDialog> createState() => _ProductCreateDialogState();
}

class _ProductCreateDialogState extends State<ProductCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _apiProvider = ApiProvider();
  final _productName = TextEditingController();
  final _atomicPrice = TextEditingController();

  void clearForm() {
    _productName.text = "";
    _atomicPrice.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(apiProvider: _apiProvider),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is LoadingProduct) {
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const LoadingIndicator();
                },
              ),
            );
          }
          if (state is SuccessCreate) {
            clearForm();
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const MessageDialog(
                      title: "Success", message: "New Product has been added.");
                },
              ),
            );
          }
          if (state is Failure) {
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback(
                (_) => MessageDialog(title: "Error", message: state.error));
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Add a product'),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _productName,
                          decoration: const InputDecoration(
                            labelText: 'Product name',
                          ),
                          validator: (String? value) {
                            return (value != null &&
                                    !value
                                        .contains(RegExp(r'^[a-zA-Z0-9&%=]+$')))
                                ? 'No special characters'
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _atomicPrice,
                          decoration: const InputDecoration(
                            labelText: 'Atomic price',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text("Submit"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ProductBloc>().add(
                                    CreateEvent(
                                      atomicPrice: _atomicPrice.text.trim(),
                                      masterProductId: null,
                                      name: _productName.text.trim(),
                                      imageUrl:
                                          'http://placehold.jp/3d4070/ffffff/150x150.png', // placeholder image
                                      categoryId:
                                          '0005bf6b-1f11-472a-a39c-971a95a39570', // place holder categoryId
                                      isDeleted: false,
                                    ),
                                  );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
