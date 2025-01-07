import 'package:flutter/material.dart';

bool _isDialogShowing = false;

void showConnectionErrorDialog(BuildContext context) {
  if (!_isDialogShowing) {
    _isDialogShowing = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('gagal terhubung ke server'),
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
