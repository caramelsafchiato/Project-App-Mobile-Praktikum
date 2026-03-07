import 'class_mahasiswaaktif.dart';
import 'class_mahasiswaalumni.dart';

void main() {
  var mhsAktif = MahasiswaAktif();
  mhsAktif.nama = "Anang";
  mhsAktif.nim = 123456;
  mhsAktif.jurusan = "Teknik Informatika";
  mhsAktif.semester = 4;
  mhsAktif.tampilkanData();

  print("\n"); 

  var mhsAlumni = MahasiswaAlumni();
  mhsAlumni.nama = "Rendi";
  mhsAlumni.nim = 654321;
  mhsAlumni.jurusan = "Sistem Informasi";
  mhsAlumni.tahunLulus = 2023;
  mhsAlumni.tampilkanData();
}