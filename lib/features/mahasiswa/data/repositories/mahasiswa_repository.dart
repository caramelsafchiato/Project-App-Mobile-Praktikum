import '../../../../core/network/dio_client.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final DioClient _dioClient;
  MahasiswaRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dioClient.dio.get('/comments');
      final List<dynamic> data = response.data;
      // Ambil 20 data saja agar tidak terlalu panjang
      return data.take(20).map((json) => MahasiswaModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat data mahasiswa');
    }
  }
}