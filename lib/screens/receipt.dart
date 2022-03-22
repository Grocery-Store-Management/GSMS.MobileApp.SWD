import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/receipt/receipt_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/receipt_widgets/receipt_list.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  static String routeName = '/receipt_screen';

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipts'),
      ),
      body: BlocProvider(
        create: (_) => ReceiptBloc(apiProvider: apiProvider)..add(GetAllEvent()),
        child: const ReceiptList(),
      ),
    );
  }
}
