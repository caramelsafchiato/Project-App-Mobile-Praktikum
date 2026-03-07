import '../models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardData> getDashboardData() async {
    await Future.delayed(const Duration(seconds: 1));

    return DashboardData(
      userName: 'Admin D4TI',
      lastUpdate: DateTime.now(),
      stats: [
        DashboardStats(
          title: 'Total Mahasiswa',
          value: '1,200',
          subtitle: 'Meningkat dari bulan lalu',
          percentage: 8.5,
          isIncrease: true,
        ),
        DashboardStats(
          title: 'Mahasiswa Aktif',
          value: '550',
          subtitle: 'Semester Ganjil',
          percentage: 5.2,
          isIncrease: true,
        ),
        DashboardStats(
          title: 'Dosen',
          value: '650',
          subtitle: 'Total pengajar',
          percentage: 1.2,
          isIncrease: false,
        ),
        DashboardStats(
          title: 'Profile',
          value: '',
          subtitle: 'Lihat profil anda',
          percentage: 3.5,
          isIncrease: true,
        ),
      ],
    );
  }

  Future<DashboardData> refreshDashboard() async {
    return getDashboardData();
  }

  Future<DashboardStats?> getStatByTitle(String title) async {
    final data = await getDashboardData();
    try {
      return data.stats.firstWhere((stat) => stat.title == title);
    } catch (e) {
      return null;
    }
  }
}