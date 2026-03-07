import 'class_objek.dart';
import 'class_mixin.dart';

class Dosen extends Mahasiswa with DapatMengajar, MemilikiJabatan, DapatRiset {
  String? nidn;

  void infoDosen() {
    print("--- Data Dosen ---");
    tampilkanData(); 
    print("NIDN: ${nidn ?? '-'}");
    tampilkanJabatan(); 
    mengajar();
    melakukanRiset(); 
  }
}