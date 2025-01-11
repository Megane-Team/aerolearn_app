import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

Future<String?> addNilai(int idPeserta, int idPelaksanaanPelatihan) async {
  try {
    final url = '$baseURL/nilai/+';
    final response = await HttpService.postRequest(url, {
      'id_peserta': idPeserta,
      'id_pelaksanaan_pelatihan': idPelaksanaanPelatihan,
    });
    if (response.statusCode == 200) {
      return 'nilai berhasil';
    } else {
      return 'nilai gagal';
    }
  } catch (e) {
    return null;
  }
}
