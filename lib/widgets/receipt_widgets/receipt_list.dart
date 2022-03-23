import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/receipt/receipt_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/receipt_widgets/receipt_list_item.dart';

class ReceiptList extends StatefulWidget {
  const ReceiptList({Key? key}) : super(key: key);

  @override
  _ReceiptListState createState() => _ReceiptListState();
}

class _ReceiptListState extends State<ReceiptList> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiptBloc, ReceiptState>(
        listener: (context, state) {
      if (state is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      }
    }, child: BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is Initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          return ListView.builder(
            itemCount: state.receipts.length,
            itemBuilder: (context, index) {
              return ReceiptListItem(
                receipt: state.receipts[index],
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
