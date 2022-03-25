import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/blocs/product/product_bloc.dart';
import 'package:gsms_mobileapp_swd/widgets/product_widgets/product_list_item.dart';

import '../../models/category.dart';
import '../../models/product.dart';
import '../../models/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ApiProvider apiProvider = ApiProvider();
  final ScrollController _scrollController = ScrollController();
  List<Product> productList = [];
  List<String> cateNameList = [];
  List<Details> productDetailList = [];
  int page = 1;
  int pageSize = 10;
  int sort = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => ProductBloc(apiProvider: apiProvider)..add(GetAllEvent(page: page, pageSize: pageSize, sort: sort)),
      child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is Failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                ),
              );
            }
            if (state is ProductsFetched) {
              setState(() {
                productList = state.products;
                cateNameList = state.cateNameList;
                productDetailList = state.productDetailList;
              });
            }
          },
          builder: (context, state) {
            if (state is Initial) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: () async{
                context.read<ProductBloc>().add(GetAllEvent(page: 1, pageSize: pageSize, sort: sort));
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Sort by Name: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            sort = 1;
                          });
                          context.read<ProductBloc>().add(GetAllEvent(sort: sort, page: page, pageSize: pageSize));
                        }, child: Text('A-Z')),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            sort = -1;
                          });
                          context.read<ProductBloc>().add(GetAllEvent(sort: sort, page: page, pageSize: pageSize));
                        }, child: Text('Z-A')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController..addListener(() {
                        if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
                          setState(() {
                            page += 1;
                          });
                          context.read<ProductBloc>().add(GetAllEvent(sort: sort, page: page, pageSize: pageSize));
                        }
                      }),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return ProductListItem(
                          product: productList[index],
                          cateName: cateNameList[index],
                          details: productDetailList[index],
                          apiProvider: apiProvider,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}