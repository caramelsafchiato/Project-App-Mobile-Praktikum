import 'class_objek.dart';

class MahasiswaAlumni extends Mahasiswa {
  int? tahunLulus;

  @override
  void tampilkanData() {
    print("--- Data Mahasiswa Alumni ---");
    super.tampilkanData();
    print("Tahun Lulus: ${tahunLulus ?? 'Belum diisi'}");
  }
}