import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/product_bloc/product_bloc.dart';

class ProductCreateDialog extends StatefulWidget {
  const ProductCreateDialog({Key? key}) : super(key: key);

  @override
  State<ProductCreateDialog> createState() => _ProductCreateDialogState();
}

class _ProductCreateDialogState extends State<ProductCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _atomicPrice = TextEditingController();

  @override
  void dispose() {
    _productName.dispose();
    _atomicPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc()..add(CreateEvent(atomicPrice: _atomicPrice as double)),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state){
          if (state is LoadingProduct) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => loadingIndicator(context, "Loading..."));
          } else if (state is SuccessCreate) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Success", "Add Product Success"));
          } else if (state is Failure) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Error", state.error));
          }
        },
        builder: (context, state) {
          return AlertDialog(
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _productName,
                        decoration: const InputDecoration(
                          labelText: 'Product name',
                        ),
                        validator: (String? value) {
                          return (value != null &&
                                  !value.contains(RegExp(r'^[a-zA-Z0-9&%=]+$')))
                              ? 'No special characters'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
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
                        child: Text("Submit"),
                        onPressed: () {
                          // TODO: onPressed save date to form and call createProduct
                          if (_formKey.currentState!.validate()) {
                            context.read<ProductBloc>().add(
                                  CreateEvent(
                                    atomicPrice: _atomicPrice.text as double,
                                    masterProductId: null,
                                    name: _productName.text.trim(),
                                    imageUrl: 'http://placehold.jp/3d4070/ffffff/150x150.png', // placeholder image
                                    categoryId: '0005bf6b-1f11-472a-a39c-971a95a39570', // place holder categoryId
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

void loadingIndicator(BuildContext context, String title){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Center(
              child: Text(title, style: TextStyle(fontSize: 20),),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],),
          ),
        );
      }
  );
}

void messageDialog(BuildContext context, String title, String message){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Center(
            child: Text(title, style: TextStyle(fontSize: 20),),
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
          ],
        );
      }
  );
}