import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/brand/brand_bloc.dart';
import 'package:gsms_mobileapp_swd/models/brand.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/brand_widgets/brand_list_item.dart';
import 'package:gsms_mobileapp_swd/widgets/circular_loading.dart';

class BrandList extends StatefulWidget {
  const BrandList({Key? key, this.sortedBrandList}) : super(key: key);

  final List<Brand>? sortedBrandList;

  @override
  _BrandListState createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  final ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brands'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CreateDialog(apiProvider: apiProvider);
                  },
                );
              },
              icon: const Icon(Icons.add)
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CreateDialog(apiProvider: apiProvider);
                  },
                );
              },
              icon: const Icon(Icons.search)
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SortDialog(apiProvider: apiProvider);
                  },
                );
              },
              icon: const Icon(Icons.sort)
          ),
        ],
      ),
      body: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is Initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Loaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BrandBloc>().add(GetAllEvent(page: 1));
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
          }
          if (widget.sortedBrandList != null) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BrandBloc>().add(GetAllEvent(page: 1));
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.sortedBrandList?.length,
                itemBuilder: (context, index) {
                  return BrandListItem(
                    key: UniqueKey(),
                    brand: widget.sortedBrandList![index],
                    apiProvider: apiProvider,
                  );
                },
              ),
            );
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}

class SortDialog extends StatefulWidget {
  const SortDialog({
    Key? key,
    required this.apiProvider
  }) : super(key: key);

  final ApiProvider apiProvider;

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  int sort = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrandBloc(apiProvider: widget.apiProvider),
      child: BlocConsumer<BrandBloc, BrandState>(
          listener: (context, state) {
            if (state is Loading) {
              WidgetsBinding.instance!.addPostFrameCallback((_) => loadingIndicator(context, "Loading..."));
            } else if (state is Failure) {
              Navigator.of(context, rootNavigator: true).pop(); //close loading
              WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Error!", 'An error has occurred'));
            } else if (state is SortLoaded) {
              Navigator.of(context, rootNavigator: true).pop(); //close loading
              Navigator.of(context).pop(); //close dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    BlocProvider<BrandBloc>(
                      create: (_) => BrandBloc(apiProvider: widget.apiProvider)..add(SortByDateEvent(sort: sort)),
                      child: BrandList(sortedBrandList: state.sortedBrands)),
                ),
              );
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: Text('Sort By', textAlign: TextAlign.center),
              content: Container(
                height: 100.0,
                width: 80.0,
                child: ListView (
                  children: [
                    InkWell(splashColor: Colors.blueAccent ,child: TextButton(onPressed: () {
                      setState(() {
                        sort = -1;
                      });
                      context.read<BrandBloc>().add(SortByDateEvent(sort: sort));
                    }, child: Text('Sort by Date (Ascend)', style: TextStyle(color: Colors.grey, fontSize: 18.0)))),
                    InkWell(splashColor: Colors.blueAccent ,child: TextButton(onPressed: () {
                      setState(() {
                        sort = 1;
                      });
                      context.read<BrandBloc>().add(SortByDateEvent(sort: sort));
                    }, child: Text('Sort by Date (Descend)', style: TextStyle(color: Colors.grey, fontSize: 18.0)))),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

class CreateDialog extends StatefulWidget {
  const CreateDialog({
    Key? key,
    required this.apiProvider,
  }) : super(key: key);

  final ApiProvider apiProvider;

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  final formKey = GlobalKey<FormState>();
  final brandName = TextEditingController();

  void clearForm() {
    brandName.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandBloc>(
      create: (_) => BrandBloc(apiProvider: widget.apiProvider),
      child: BlocConsumer<BrandBloc, BrandState>(
        listener: (context, state) {
          if (state is Loading) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => loadingIndicator(context, "Loading..."));
          } else if (state is Failure) {
            Navigator.of(context, rootNavigator: true).pop(); //close loading
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Error!", 'An error has occurred'));
          } else if (state is CreateSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); //close loading
            Navigator.of(context).pop(); //close dialog
          }
        },
        builder: (context, state) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: brandName,
                          decoration: const InputDecoration(
                            labelText: 'Brand name',
                          ),
                          validator: (String? value) {
                            return (value != null &&
                                value.contains(RegExp(r'^[0-9&%=]+$')))
                                ? 'No special characters'
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text("Submit"),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<BrandBloc>().add(CreateEvent(
                                  brandName: brandName.text.trim()));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum PopMenuOptions { sortByDateAscend, sortByDateDescend }
