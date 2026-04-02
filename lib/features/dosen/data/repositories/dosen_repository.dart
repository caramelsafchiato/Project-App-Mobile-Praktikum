import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/dosen_model.dart';

class DosenRepository {
  final DioClient _dioClient = DioClient();

  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dioClient.dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat data dosen');
    }
  }
}