class MahasiswaModel {
  final int id;
  final String nama;
  final String email;
  final String deskripsi;
  final String status;

  MahasiswaModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.deskripsi,
    required this.status,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? 0;
    return MahasiswaModel(
      id: id,
      nama: json['name'] ?? '',
      email: json['email'] ?? '',
      deskripsi: json['body'] ?? '',
      // Logika manual: ID Genap = Aktif, Ganjil = Tidak Aktif
      status: id % 2 == 0 ? 'Aktif' : 'Tidak Aktif',
    );
  }
}