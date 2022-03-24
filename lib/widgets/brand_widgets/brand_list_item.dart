import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/brand/brand_bloc.dart';
import 'package:gsms_mobileapp_swd/models/brand.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

import '../circular_loading.dart';

// This is the type used by the popup menu below.
enum PopMenuOptions { edit, delete }

class BrandListItem extends StatefulWidget {
  const BrandListItem(
      {Key? key, required this.brand, required this.apiProvider})
      : super(key: key);

  final Brand brand;
  final ApiProvider apiProvider;

  @override
  State<BrandListItem> createState() => _BrandListItemState();
}

class _BrandListItemState extends State<BrandListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: ListTile(
          isThreeLine: true,
          leading: const Icon(Icons.shop, size: 30),
          title: Text('${widget.brand.name}'),
          subtitle: Text(
              'Created Date: ${widget.brand.createdDate?.substring(0, 10)}\n'
              'Status: ${(widget.brand.isDeleted != null) ? 'Not Deleted' : 'Deleted'}'),
          trailing: PopupMenuButton<PopMenuOptions>(
            icon: const Icon(Icons.more_vert),
            onSelected: (PopMenuOptions result) {
              setState(
                () {
                  if (result == PopMenuOptions.edit) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditDialog(
                            apiProvider: widget.apiProvider,
                            brand: widget.brand,
                        );
                      },
                    );
                  }
                  if (result == PopMenuOptions.delete) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                            apiProvider: widget.apiProvider,
                            brandId: widget.brand.id!,
                        );
                      },
                    );
                  }
                },
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<PopMenuOptions>>[
              const PopupMenuItem<PopMenuOptions>(
                value: PopMenuOptions.edit,
                child: Text('Edit'),
              ),
              const PopupMenuItem<PopMenuOptions>(
                value: PopMenuOptions.delete,
                child: Text('Delete', style: TextStyle(color: Colors.redAccent),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditDialog extends StatefulWidget {
  const EditDialog({
    Key? key, required this.apiProvider, required this.brand
  }) : super(key: key);

  final ApiProvider apiProvider;
  final Brand brand;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final formKey = GlobalKey<FormState>();
  final newBrandName = TextEditingController();

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
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Error!", 'An error has occurred.'));
          } else if (state is UpdateSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); //close loading
            Navigator.of(context).pop(); //close dialog
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Success!", "Brand ${widget.brand.name} was edited."));
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
                          controller: newBrandName,
                          decoration: InputDecoration(
                            labelText: '${widget.brand.name}',
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
                              context.read<BrandBloc>().add(UpdateEvent(
                                brand: Brand(
                                    id: widget.brand.id,
                                    name: newBrandName.text.trim(),
                                    createdDate: widget.brand.createdDate,
                                    isDeleted: widget.brand.isDeleted
                                )
                              ));
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

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog(
      {Key? key, required this.apiProvider, required this.brandId})
      : super(key: key);

  final ApiProvider apiProvider;
  final String brandId;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
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
          } else if (state is DeleteSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); //close loading
            Navigator.of(context).pop(); //close dialog
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(context, "Success!", "Brand was deleted."));
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Do you want to delete this item?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    context.read<BrandBloc>()
                      .add(DeleteEvent(getId: widget.brandId));
                  },
                  child: const Text('Yes')),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      ),
    );
  }
}
