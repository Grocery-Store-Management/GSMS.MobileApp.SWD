import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/receipt_detail/receipt_detail_bloc.dart';
import 'package:gsms_mobileapp_swd/models/receipt_detail.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

class ReceiptDetailScreen extends StatelessWidget {
  const ReceiptDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiProvider apiProvider = ApiProvider();
    final String getId = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt Detail'),
      ),
      body: BlocProvider(
        create: (_) => ReceiptDetailBloc(apiProvider: apiProvider)..add(GetIdEvent(getId: getId)),
        child: const ReceiptDetailList(),
      ),
    );
  }
}

class ReceiptDetailList extends StatefulWidget {
  const ReceiptDetailList({Key? key}) : super(key: key);

  @override
  State<ReceiptDetailList> createState() => _ReceiptDetailListState();
}

class _ReceiptDetailListState extends State<ReceiptDetailList> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptDetailBloc, ReceiptDetailState>(
      builder: (context, state) {
        if (state is Initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailLoaded) {
          return ListView.builder(
            itemCount: state.details.length,
            itemBuilder: (context, index) {
              return ReceiptDetailItem(
                detail: state.details[index],
                image: state.images[index]
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ReceiptDetailItem extends StatelessWidget {
  const ReceiptDetailItem({
    Key? key, required this.detail, required this.image
  }) : super(key: key);

  final ReceiptDetail detail;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.94,
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
                        child: Image.network(
                            image,
                            fit: BoxFit.fill),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${detail.name?.replaceRange(20, detail.name?.length, '...')}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          "Quantity: ${detail.quantity}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Price: ${detail.price} VND",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}