import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../providers/dosen_provider.dart';
import '../widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: dosenState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (dosenList) {
          return RefreshIndicator(
            onRefresh: () async => ref.refresh(dosenNotifierProvider),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 120.0,
                  pinned: true,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: const Text('Data Pengajar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Memanggil kartu dengan parameter dosen dan index
                        return ModernDosenCard(
                          dosen: dosenList[index],
                          index: index,
                        );
                      },
                      childCount: dosenList.length,
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