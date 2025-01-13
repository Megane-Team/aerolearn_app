import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Assets {
  static const path = 'assets/image';

  static String logos(String name) {
    return '$path/logo/$name.png';
  }

  static String icons(String name) {
    return '$path/icon/$name.png';
  }

  static Future<Widget> filesMateri(String name) async {
    final token = await SessionService.getToken();
    try {
      final response =
          await HttpService.getRequest('$baseURL/file/e-materi/$name');
      if (response.statusCode == 200) {
        if (name.endsWith('.pdf')) {
          return SfPdfViewer.network(
            '$baseURL/file/e-materi/$name',
            headers: {
              'authorization': 'Bearer $token',
            },
          );
        } else {
          return Center(child: Text('Unsupported file type'));
        }
      } else {
        return Center(child: Text('File not found'));
      }
    } catch (e) {
      return Center(child: Text('Error: $e'));
    }
  }

  static Future<Widget> filesSertifikat(String id) async {
    try {
      final response =
          await HttpService.getRequest('$baseURL/file/e-sertifikat/$id');

      if (response.statusCode == 200) {
        return SfPdfViewer.network(
          '$baseURL/file/e-sertifikat/$id',
        );
      } else {
        return Container();
      }
    } catch (e) {
      return Container();
    }
  }

  static Future<Widget> filesKonten(String name) async {
    final token = await SessionService.getToken();
    try {
      final response =
          await HttpService.getRequest('$baseURL/file/konten/$name');
      if (response.statusCode == 200) {
        return Image.network(
          '$baseURL/file/konten/$name',
          headers: {
            'authorization': 'Bearer $token',
          },
        );
      } else {
        return Container();
      }
    } catch (e) {
      return Text('tidak dapat terhubung ke server');
    }
  }
}
