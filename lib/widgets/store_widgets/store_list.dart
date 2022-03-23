import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/store/store_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/store_widgets/store_list_item.dart';

class StoreList extends StatefulWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
        listener: (context, state) {
      if (state is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      }
    }, child: BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is Initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          return ListView.builder(
            itemCount: state.stores.length,
            itemBuilder: (context, index) {
              return StoreListItem(
                store: state.stores[index],
                brandName: state.brandName[index],
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
