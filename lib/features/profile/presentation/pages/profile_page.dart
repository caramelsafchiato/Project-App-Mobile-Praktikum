import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (profile) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 220.0,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: AppConstants.gradientPurple),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(profile.photoUrl),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        profile.nama,
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        profile.status,
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildSectionTitle('Informasi Akademik'),
                  _buildCard([
                    ProfileInfoTile(icon: Icons.badge_outlined, label: 'NIM', value: profile.nim),
                    ProfileInfoTile(icon: Icons.school_outlined, label: 'Program Studi', value: profile.prodi),
                    ProfileInfoTile(icon: Icons.email_outlined, label: 'Email Institusi', value: profile.email, isLast: true),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Pengaturan Akun'),
                  _buildCard([
                    const ProfileInfoTile(icon: Icons.lock_outline, label: 'Keamanan', value: 'Ganti Kata Sandi'),
                    const ProfileInfoTile(icon: Icons.logout, label: 'Sesi', value: 'Keluar Aplikasi', color: Colors.red, isLast: true),
                  ]),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(children: children),
    );
  }
}