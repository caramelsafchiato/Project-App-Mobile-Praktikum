import 'dart:io';

void main() {
  List<String> names = ['Alfa', 'beta', 'Charlie'];
  print('Names: $names');

  names.add('Delta');
  print('Names setelah ditambahkan: $names');

  print('Element pertama: ${names[0]}');
  print('Element kedua: ${names[1]}');

  names[1] = 'Bravo';
  print('Names setelah diubah: $names');

  names.remove('Charlie');
  print('Names setelah dihapus: $names');

  print('Jumlah data: ${names.length}');

  print('Menampilkan setiap elemen:');
  for (String name in names) {
    print(name);
  }

  List<String> dataList = [];
  print('Data List Kosong: $dataList');

  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah List: ');
    String input = stdin.readLineSync()!;
    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid! Masukkan angka yang benar.');
    }
  }
  
  for (int i = 0; i < count; i++) {
    stdout.write('data ke-${i + 1}: ');
    String x = stdin.readLineSync()!;
    dataList.add(x);
  }

  print('Data List:');
  print(dataList);


  print('\n=== MANIPULASI DATA ===');

  stdout.write('Masukkan index yang ingin ditampilkan: ');
  int indexTampil = int.parse(stdin.readLineSync()!);
  if (indexTampil < dataList.length) {
    print('Data pada index $indexTampil adalah: ${dataList[indexTampil]}');
  } else {
    print('Index tidak ditemukan!');
  }

  stdout.write('\nMasukkan index yang ingin diubah: ');
  int indexUbah = int.parse(stdin.readLineSync()!);
  if (indexUbah < dataList.length) {
    stdout.write('Masukkan data baru: ');
    String dataBaru = stdin.readLineSync()!;
    dataList[indexUbah] = dataBaru; 
    print('Data berhasil diubah!');
  }

  stdout.write('\nMasukkan index yang ingin dihapus: ');
  int indexHapus = int.parse(stdin.readLineSync()!);
  if (indexHapus < dataList.length) {
    dataList.removeAt(indexHapus); 
    print('Data pada index $indexHapus berhasil dihapus!');
  }

  print('\n=== SEMUA DATA ===');
  for (int i = 0; i < dataList.length; i++) {
    print('Index $i: ${dataList[i]}');
  }

}














