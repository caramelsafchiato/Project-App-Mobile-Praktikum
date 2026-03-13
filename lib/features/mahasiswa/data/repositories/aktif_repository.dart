import 'package:dio/dio.dart';
import '../models/aktif_model.dart';

class AktifRepository {
  final Dio _dio = Dio();

  Future<List<AktifModel>> getPostsAktif() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts',
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        // Kita ambil 10 data saja untuk contoh
        return data.take(10).map((json) => AktifModel.fromJson(json)).toList();
      }
      throw Exception('Gagal ambil data posts');
    } catch (e) {
      throw Exception('Kesalahan: $e');
    }
  }
}