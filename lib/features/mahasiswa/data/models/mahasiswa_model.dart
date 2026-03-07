class MahasiswaModel {
  final String nama;
  final String nim;
  final String email;
  final String status; // Aktif, Lulus, Cuti

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.status,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? 'Aktif',
    );
  }
}