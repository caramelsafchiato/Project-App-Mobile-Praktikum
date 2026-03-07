import 'package:flutter/material.dart';
import '../../data/models/dosen_model.dart';

class ModernDosenCard extends StatelessWidget {
  final DosenModel dosen;
  final int index; // Pastikan baris ini ada

  const ModernDosenCard({
    super.key,
    required this.dosen,
    required this.index, // Dan baris ini juga ada
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> accentColors = [
      Colors.purple,
      Colors.blue,
      Colors.pink,
      Colors.orange,
    ];
    final color = accentColors[index % accentColors.length];

    return Container(
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
              Container(width: 6, color: color),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: color.withOpacity(0.1),
                  child: Text(
                    dosen.nama[0].toUpperCase(),
                    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dosen.nama,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                    ),
                    const SizedBox(height: 6),
                    _buildInfoRow(Icons.badge_outlined, 'NIP: ${dosen.nip}'),
                    const SizedBox(height: 4),
                    _buildInfoRow(Icons.email_outlined, dosen.email),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
              const SizedBox(width: 16),
            ],
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
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}