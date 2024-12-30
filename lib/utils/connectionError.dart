import 'package:flutter/material.dart';

bool _isDialogShowing = false;

void showConnectionErrorDialog(BuildContext context) {
  if (!_isDialogShowing) {
    _isDialogShowing = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connection Error'),
          content: Text(
              'Failed to connect to the server. Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isDialogShowing = false;
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
