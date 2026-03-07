import 'dart:io';

void main() {
  Set<String> burung = {'Merpati', 'Elang', 'Kakatua'};
  print('Burung: $burung');


  burung.add('Pipit');
  print('Burung setelah ditambahkan: $burung');

  burung.add('Elang');
  print('Setelah tambah duplicate (Elang): $burung');

  burung.remove('Merpati');
  print('Setelah hapus Merpati: $burung');

  bool adaElang = burung.contains('Elang');
  print('Apakah ada Elang? $adaElang');

  print('Total data burung: ${burung.length}');

  Set<String> dataSet = {'a', 'b', 'c', 'd', 'e'};

  // Menampilkan Semua Data awal
  print('=== SEMUA DATA ===');
  int i = 1;
  for (String item in dataSet) {
    print('${i++}. $item');
  }
  print('Total data: ${dataSet.length}');

  // --- Proses Tambah Data ---
  stdout.write('\nMasukkan data baru: ');
  String baru = stdin.readLineSync()!;
  dataSet.add(baru);
  print('Data "$baru" berhasil ditambahkan!');

  // --- Proses Hapus Data ---
  stdout.write('Masukkan data yang ingin dihapus: ');
  String hapus = stdin.readLineSync()!;
  if (dataSet.contains(hapus)) {
    dataSet.remove(hapus);
    print('Data "$hapus" berhasil dihapus!');
  } else {
    print('Data "$hapus" tidak ditemukan!');
  }

  // --- Proses Cek Data ---
  stdout.write('Masukkan data yang ingin dicek: ');
  String cek = stdin.readLineSync()!;
  if (dataSet.contains(cek)) {
    print('Data "$cek" ada di Set!');
  } else {
    print('Data "$cek" tidak ada di Set!'); // Sesuai output "tidak ada di Set!" di gambar
  }

}

