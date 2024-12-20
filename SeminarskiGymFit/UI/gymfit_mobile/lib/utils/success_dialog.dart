import 'package:flutter/material.dart';

import '../helpers/constants.dart';

Future<dynamic> showSuccessDialog(BuildContext context, String? message) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: black,
        title: const Text('Info', style: TextStyle(color: Colors.teal)),
        content: Text(message ?? 'Uspjesno!',
            style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}