import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/brand/brand_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/widgets/brand_widgets/brand_list.dart';
import 'package:gsms_mobileapp_swd/widgets/loading_indicator.dart';
import 'package:gsms_mobileapp_swd/widgets/message_dialog.dart';

// TODO: Add Pull to Refresh
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
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocProvider<BrandBloc>(
        create: (_) => BrandBloc(apiProvider: apiProvider)..add(GetAllEvent()),
        child: const BrandList(),
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
            WidgetsBinding.instance!
                .addPostFrameCallback((_) => const LoadingIndicator());
          } else if (state is CreateSuccess) {
            clearForm();
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback(
                    (_) => const MessageDialog(title: "Success", message: "Add Product Success"));
          } else if (state is Failure) {
            Navigator.of(context, rootNavigator: true).pop();
            WidgetsBinding.instance!.addPostFrameCallback(
                    (_) => const MessageDialog(title: "Error", message: 'An error has occured'));
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
                            return (value != null && value.contains(RegExp(r'^[0-9&%=]+$')))
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
                              context.read<BrandBloc>().add(CreateEvent(brandName: brandName.text.trim()));
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
