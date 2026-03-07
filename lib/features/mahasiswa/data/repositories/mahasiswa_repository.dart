import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      MahasiswaModel(nama: 'Budi Santoso', nim: '220101001', email: 'budi@student.com', status: 'Aktif'),
      MahasiswaModel(nama: 'Siti Aminah', nim: '220101002', email: 'siti@student.com', status: 'Aktif'),
      MahasiswaModel(nama: 'Andi Wijaya', nim: '210101005', email: 'andi@student.com', status: 'Lulus'),
    ];
  }
}