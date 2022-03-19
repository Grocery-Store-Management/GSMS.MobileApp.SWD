import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({Key? key, required this.title, this.message})
      : super(key: key);

  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      content: Text('$message'),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        )
      ],
    );
  }
}
