import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/blocs/product/product_bloc.dart';
import 'package:gsms_mobileapp_swd/widgets/product_widgets/product_list_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is Failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsFetched) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductListItem(
                  product: state.products[index],
                  cateName: state.cateNameList[index],
                  details: state.productDetailList[index],
                  apiProvider: apiProvider,
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: Text('No Products'),
              ),
            );
          }
        }
    );
  }
}