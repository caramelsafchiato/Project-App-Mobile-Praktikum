import 'package:dio/dio.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final Dio _dio = Dio();

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/comments',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'Flutter-App/1.0',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        // Kita batasi hanya mengambil 15 data pertama agar tidak terlalu panjang
        return data.take(15).map((json) => MahasiswaModel.fromJson(json)).toList();
      }
      throw Exception('Gagal memuat data mahasiswa');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}