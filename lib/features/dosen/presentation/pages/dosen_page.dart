import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common_widgets.dart'; 
import '../../data/models/dosen_model.dart';
import '../providers/dosen_provider.dart';
import '../widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau state data dari API dan Local Storage
    final dosenState = ref.watch(dosenNotifierProvider);
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(dosenNotifierProvider),
            tooltip: "Refresh",
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Data dari SharedPreferences (Local Storage)
          SavedUserSection(savedUsers: savedUsers, ref: ref),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Dosen (API)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),

          // Section 2: Daftar Dosen dari API
          Expanded(
            child: dosenState.when(
              loading: () => const LoadingWidget(),
              error: (error, stack) => CustomErrorWidget(
                message: 'Gagal memuat data: ${error.toString()}',
                onRetry: () => ref.read(dosenNotifierProvider.notifier).loadDosenList(),
              ),
              data: (dosenList) => DosenListWithSave(
                dosenList: dosenList,
                onRefresh: () => ref.invalidate(dosenNotifierProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET: SEKSI DATA TERSIMPAN ---
class SavedUserSection extends StatelessWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  final WidgetRef ref;

  const SavedUserSection({super.key, required this.savedUsers, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16, color: Colors.purple),
              const SizedBox(width: 6),
              const Text(
                'Tersimpan di Local Storage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              // Tombol Hapus Semua Data Lokal
              TextButton(
                onPressed: () async {
                  await ref.read(dosenNotifierProvider.notifier).clearSavedUsers();
                  ref.invalidate(savedUsersProvider);
                },
                child: const Text('Hapus Semua', style: TextStyle(color: Colors.red, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          savedUsers.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => const Text('Gagal memuat data lokal', style: TextStyle(color: Colors.red)),
            data: (users) {
              if (users.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Text('Belum ada data. Tap ikon simpan di bawah.', 
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, indent: 12, endIndent: 12),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      dense: true,
                      title: Text(user['username'] ?? '-', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('ID: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 16, color: Colors.red),
                        onPressed: () async {
                          await ref.read(dosenNotifierProvider.notifier).removeSavedUser(user['user_id']!);
                          ref.invalidate(savedUsersProvider);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      final date = DateTime.parse(isoString);
      return '${date.day}/${date.month} ${date.hour}:${date.minute}';
    } catch (e) {
      return isoString;
    }
  }
}

// --- WIDGET: LIST DOSEN DENGAN TOMBOL SAVE ---
class DosenListWithSave extends ConsumerWidget {
  final List<DosenModel> dosenList;
  final VoidCallback onRefresh;

  const DosenListWithSave({super.key, required this.dosenList, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: dosenList.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text(dosen.name[0])),
              title: Text(dosen.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${dosen.email}\n${dosen.address.city}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save_alt_rounded, color: Colors.purple),
                onPressed: () async {
                  await ref.read(dosenNotifierProvider.notifier).saveSelectedDosen(dosen);
                  ref.invalidate(savedUsersProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${dosen.username} disimpan ke lokal')),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}