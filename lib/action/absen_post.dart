// ignore_for_file: file_names
import 'dart:convert';
import 'package:aerolearn/utils/connection_error.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

Future<String?> absenPeserta(
    context, int? idMateri, int? idExam, int idPelaksanaanPelatihan) async {
  try {
    final url = '$baseURL/absensi/+';
    final response = await HttpService.postRequest(url, {
      'id_materi': idMateri,
      'id_pelaksanaan_pelatihan': idPelaksanaanPelatihan,
      'id_exam': idExam,
    });
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else if (response.statusCode == 401) {
      return 'anda sudah absen';
    } else {
      throw Exception('Failed to absen');
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}
