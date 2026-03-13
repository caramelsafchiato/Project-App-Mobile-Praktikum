class MahasiswaModel {
  final int id;
  final String nama;
  final String email;
  final String deskripsi;
  final String status; // Tambahkan baris ini

  MahasiswaModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.deskripsi,
    required this.status, // Tambahkan baris ini
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      id: json['id'] ?? 0,
      nama: json['name'] ?? '',
      email: json['email'] ?? '',
      deskripsi: json['body'] ?? '',
      status: 'Aktif', 
    );
  }
}