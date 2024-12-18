// ignore_for_file: file_names

import 'package:flutter/material.dart';

void showConnectionErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Koneksi gagal'),
        content: Text(
            'Gagal untuk menyambung pada server. Tolong cek koneksi internet anda lalu coba lagi.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
