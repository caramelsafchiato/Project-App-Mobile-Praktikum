import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_model.dart';

class ModernMahasiswaCard extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final int index;
  final VoidCallback? onTap;

  const ModernMahasiswaCard({
    super.key,
    required this.mahasiswa,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> accentColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];
    final color = accentColors[index % accentColors.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Garis aksen samping
                Container(width: 6, color: color),
                const SizedBox(width: 16),
                // Avatar Inisial
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: color.withOpacity(0.1),
                    child: Text(
                      mahasiswa.nama[0].toUpperCase(),
                      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Info Mahasiswa
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mahasiswa.nama,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      _buildInfoRow(Icons.numbers_outlined, 'NIM: ${mahasiswa.nim}'),
                      const SizedBox(height: 4),
                      _buildInfoRow(Icons.verified_user_outlined, mahasiswa.status),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
      ],
    );
  }
}