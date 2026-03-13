class AktifModel {
  final int id;
  final String judul; // Diambil dari field 'title'
  final String isi;   // Diambil dari field 'body'

  AktifModel({
    required this.id,
    required this.judul,
    required this.isi,
  });

  factory AktifModel.fromJson(Map<String, dynamic> json) {
    return AktifModel(
      id: json['id'] ?? 0,
      judul: json['title'] ?? '',
      isi: json['body'] ?? '',
    );
  }
}