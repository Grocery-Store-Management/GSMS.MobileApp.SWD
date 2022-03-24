import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/brand/brand_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/brand_widgets/brand_list_item.dart';

class BrandList extends StatefulWidget {
  const BrandList({Key? key}) : super(key: key);

  @override
  _BrandListState createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  final ApiProvider apiProvider = ApiProvider();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandBloc>(
      create: (_) => BrandBloc(apiProvider: apiProvider)..add(GetAllEvent(page: page)),
      child: BlocListener<BrandBloc, BrandState>(
          listener: (context, state) {
        if (state is Failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      }, child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is Initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BrandBloc>().add(GetAllEvent(page: page));
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.brands.length,
                itemBuilder: (context, index) {
                  return BrandListItem(
                    key: UniqueKey(),
                    brand: state.brands[index],
                    apiProvider: apiProvider,
                  );
                },
              ),
            );
          } else if (state is SortLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BrandBloc>().add(GetAllEvent(page: page));
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.sortedBrands.length,
                itemBuilder: (context, index) {
                  return BrandListItem(
                    key: UniqueKey(),
                    brand: state.sortedBrands[index],
                    apiProvider: apiProvider,
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      )),
    );
  }
}
