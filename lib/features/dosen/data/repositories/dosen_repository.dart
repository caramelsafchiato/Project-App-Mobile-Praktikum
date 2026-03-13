import 'package:dio/dio.dart';
import '../models/dosen_model.dart';

class DosenRepository {
  final Dio _dio = Dio();

  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // Tambahkan User-Agent jika masih 403
            'User-Agent': 'PostmanRuntime/7.29.2', 
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => DosenModel.fromJson(json)).toList();
      }
      throw Exception('Gagal memuat data: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error koneksi: $e');
    }
  }
}