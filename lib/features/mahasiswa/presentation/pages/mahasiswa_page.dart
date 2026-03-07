import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  // 1. Tambahkan parameter filterStatus agar bisa menerima instruksi dari Dashboard
  final String? filterStatus;
  
  const MahasiswaPage({super.key, this.filterStatus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          // 2. LOGIKA FILTER: Menyaring list berdasarkan status jika filterStatus tidak null
          final filteredList = filterStatus == null 
              ? list 
              : list.where((mhs) => mhs.status == filterStatus).toList();

          return RefreshIndicator(
            onRefresh: () async => ref.refresh(mahasiswaNotifierProvider),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Header Modern
                SliverAppBar(
                  expandedHeight: 120.0,
                  pinned: true,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    // 3. Judul dinamis: berubah sesuai filter yang aktif
                    title: Text(
                      filterStatus == null ? 'Data Mahasiswa' : 'Mahasiswa $filterStatus',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppConstants.gradientPurple,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                // Daftar Mahasiswa yang sudah difilter
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ModernMahasiswaCard(
                        // 4. Gunakan filteredList agar datanya benar
                        mahasiswa: filteredList[index],
                        index: index,
                        onTap: () {},
                      ),
                      childCount: filteredList.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}