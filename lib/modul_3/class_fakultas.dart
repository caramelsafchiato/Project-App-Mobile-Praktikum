import 'class_objek.dart';
import 'class_mixin.dart';

class Fakultas extends Mahasiswa with MemilikiJabatan {
  String? namaFakultas;

  void infoFakultas() {
    print("--- Data Fakultas ---");
    print("Fakultas: ${namaFakultas ?? 'Belum ditentukan'}");
    jabatan = "Dekan"; 
    tampilkanJabatan();
  }
}