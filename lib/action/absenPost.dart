// ignore_for_file: file_names
import 'dart:convert';
import 'package:aerolearn/utils/connectionError.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

Future<String?> absenPeserta(
    context, int idMateri, int idPelaksanaanPelatihan) async {
  try {
    final url = '$baseURL/absensi/+';
    final response = await HttpService.postRequest(url, {
      'id_materi': idMateri,
      'id_pelaksanaan_pelatihan': idPelaksanaanPelatihan,
    });
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      return 'anda sudah absen';
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}
