import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/category/category_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/category_widgets/category_list_item.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
      if (state is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      }
    }, child: BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is Initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          return ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              return CategoryListItem(
                category: state.categories[index],
                apiProvider: apiProvider,
              );
            },
          );
        } else {
          return Container();
        }
      },
    ));
  }
}
