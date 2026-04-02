import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common_widgets.dart'; // Ganti ke widgets.dart jika beda nama
import '../providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  final String? filterStatus; // null untuk 'Semua', 'Aktif' untuk filter aktif
  
  const MahasiswaPage({super.key, this.filterStatus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaNotifierProvider);
    final savedMhs = ref.watch(savedMhsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(filterStatus == 'Aktif' ? 'Mahasiswa Aktif' : 'Daftar Mahasiswa'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // SEKSI ATAS: DATA OFFLINE DARI LOCAL STORAGE [cite: 261-263]
          _buildSavedSection(savedMhs, ref),
          
          const Divider(height: 1),
          
          // SEKSI BAWAH: DATA ONLINE DARI API [cite: 234-245]
          Expanded(
            child: state.when(
              loading: () => const LoadingWidget(),
              error: (e, _) => CustomErrorWidget(
                message: "Gagal ambil data API",
                onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).loadMahasiswaList(),
              ),
              data: (list) {
                // Filter logika status [cite: 480-482]
                final filtered = filterStatus == null 
                    ? list 
                    : list.where((m) => m.status == filterStatus).toList();

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final mhs = filtered[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(child: Text(mhs.id.toString())),
                        title: Text(mhs.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${mhs.email}\nStatus: ${mhs.status}'),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.save_rounded, color: Colors.blue),
                          onPressed: () async {
                            await ref.read(mahasiswaNotifierProvider.notifier).saveMahasiswa(mhs);
                            ref.invalidate(savedMhsProvider); // Update seksi atas otomatis [cite: 451]
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${mhs.nama} disimpan ke HP!'))
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedSection(AsyncValue<List<Map<String, String>>> savedMhs, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.blue.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.sd_storage_outlined, size: 16, color: Colors.blue),
              SizedBox(width: 8),
              Text("Tersimpan Offline", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          savedMhs.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => const Text("Gagal muat data lokal"),
            data: (users) => users.isEmpty 
              ? const Text("Belum ada data favorit.", style: TextStyle(color: Colors.grey, fontSize: 12))
              : SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemBuilder: (context, i) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(users[i]['username']!, style: const TextStyle(fontSize: 11)),
                        backgroundColor: Colors.white,
                        onDeleted: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).deleteSavedMhs(users[i]['user_id']!);
                          ref.invalidate(savedMhsProvider); // Refresh otomatis [cite: 399]
                        },
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}VV