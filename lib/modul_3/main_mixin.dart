import 'class_dosen.dart';
import 'class_fakultas.dart';

void main() {
  var dosenTI = Dosen();
  dosenTI.nama = "Bpk. Anang Prasetyo";
  dosenTI.nidn = "00112233";
  dosenTI.jurusan = "Teknik Informatika";
  dosenTI.jabatan = "Dosen Senior";
  dosenTI.infoDosen();

  print("\n" + "="*30 + "\n");

  var fakultasTI = Fakultas();
  fakultasTI.namaFakultas = "Fakultas Teknologi Informasi";
  fakultasTI.infoFakultas();
}