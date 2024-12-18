import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Assets {
  static const path = 'assets/image';

  static String logos(String name) {
    return '$path/logo/$name.png';
  }

  static String icons(String name) {
    return '$path/icon/$name.png';
  }

  static Future<Widget> files(String name) async {
    final token = await SessionService.getToken();
    try{
      final response = await HttpService.getRequest(
        '$baseURL/file/e-materi/$name'
      );

      if(response.statusCode == 200){
        return SfPdfViewer.network(
          '$baseURL/file/e-materi/$name',
          headers: {
            'authorization': 'Bearer $token',
          },
        );
      }else{
        throw Exception('Failed to load Materi data');
      }
    }catch(e){
      return Text('Not Found');
    }

  }

}
