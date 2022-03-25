import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/brand_widgets/brand_list.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key}) : super(key: key);

  static String routeName = '/brand_screen';

  @override
  State<BrandScreen> createState() => _OrderState();
}

class _OrderState extends State<BrandScreen> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return const BrandList();
  }
}
