import 'dart:io';

void main() {
  // --- a & b. Membuat Map dengan data awal ---
  Map<String, String> data = {
    'Anang': '081234567890',
    'Arman': '082345678901',
    'Doni': '083456789012',
  };
  print('Data awal: $data');

  data['Rio'] = '084567890123';
  print('Data setelah ditambahkan: $data');

  print('Nomor Anang: ${data['Anang']}');

  data['Arman'] = '08999999999'; 
  print('Data setelah diubah (Arman): $data');

  data.remove('Doni');
  print('Data setelah dihapus (Doni): $data');

  print('Apakah ada key "Rio"? ${data.containsKey('Rio')}');

  print('Jumlah data: ${data.length}');

  print('Semua Key: ${data.keys}');

  print('Semua Value: ${data.values}');

  print('\n' + '=' * 30);

  print('=== INPUT DATA MAHASISWA ===');
  Map<String, dynamic> mahasiswa = {};
  
  stdout.write('Masukkan NIM: ');
  mahasiswa['nim'] = stdin.readLineSync();
  
  stdout.write('Masukkan Nama: ');
  mahasiswa['nama'] = stdin.readLineSync();
  
  stdout.write('Masukkan Jurusan: ');
  mahasiswa['jurusan'] = stdin.readLineSync();
  
  stdout.write('Masukkan IPK: ');
  mahasiswa['ipk'] = stdin.readLineSync();

  print('\nData Mahasiswa: $mahasiswa');

  print('\n' + '=' * 30);

  print('=== INPUT MULTIPLE MAHASISWA ===');
  stdout.write('Masukkan jumlah mahasiswa: ');
  int jml = int.parse(stdin.readLineSync()!);
  
  List<Map<String, dynamic>> listMahasiswa = [];

  for (int i = 0; i < jml; i++) {
    print('\n--- Mahasiswa ke-${i + 1} ---');
    Map<String, dynamic> mhs = {};
    
    stdout.write('Masukkan NIM: ');
    mhs['nim'] = stdin.readLineSync();
    
    stdout.write('Masukkan Nama: ');
    mhs['nama'] = stdin.readLineSync();
    
    stdout.write('Masukkan Jurusan: ');
    mhs['jurusan'] = stdin.readLineSync();
    
    stdout.write('Masukkan IPK: ');
    mhs['ipk'] = stdin.readLineSync();
    
    listMahasiswa.add(mhs);
  }

  print('\n=== HASIL INPUT MULTIPLE ===');
  for (var m in listMahasiswa) {
    print(m);
  }

}