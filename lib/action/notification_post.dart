import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

Future<String?> addNotification(int idPeserta, String title, String detail,
    String tanggal, int idPelaksanaanPelatihan) async {
  try {
    final url = '$baseURL/notification/+';
    final response = await HttpService.postRequest(url, {
      'id_user': idPeserta,
      'title': title,
      'detail': detail,
      'tanggal': tanggal,
      'id_pelaksanaan_pelatihan': idPelaksanaanPelatihan,
    });
    if (response.statusCode == 200) {
      return 'notification berhasil dibuat';
    } else {
      return 'notification sudah dibuat';
    }
  } catch (e) {
    return null;
  }
}