import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/category/category_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/category_widgets/category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  static String routeName = '/category_screen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: BlocProvider(
        create: (_) => CategoryBloc(apiProvider: apiProvider)..add(GetAllEvent()),
        child: const CategoryList(),
      ),
    );
  }
}
