import 'class_objek.dart';

class MahasiswaAktif extends Mahasiswa {
  int? semester;

  @override
  void tampilkanData() {
    print("--- Data Mahasiswa Aktif ---");
    super.tampilkanData();
    print("Semester: ${semester ?? 'Belum diisi'}");
  }
}