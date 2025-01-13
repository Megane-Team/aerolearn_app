import 'package:flutter/material.dart';

bool _isDialogShowing = false;

void showConnectionErrorDialog(BuildContext context) {
  if (!_isDialogShowing) {
    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible:
          false, // Menyebabkan dialog tidak bisa ditutup dengan klik di luar dialog
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16.0), // Border radius lebih besar
          ),
          backgroundColor: Colors.white, // Latar belakang putih yang bersih
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Sesuaikan ukuran dialog sesuai konten
              children: [
                Icon(
                  Icons.signal_wifi_off, // Ikon yang lebih relevan
                  color: Colors
                      .red, // Warna oranye untuk menekankan masalah koneksi
                  size: 50.0,
                ),
                SizedBox(height: 20),
                Text(
                  'Gagal terhubung ke server',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Periksa koneksi internet atau coba lagi nanti.',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _isDialogShowing = false;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna tombol oranye
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    'OK',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
