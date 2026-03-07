import '../models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile() async {
    // Simulasi mengambil data dari internet/database
    await Future.delayed(const Duration(milliseconds: 500));
    return ProfileModel(
      nama: 'User Mahasiswa', // Ganti dengan namamu
      nim: '220101000',
      email: 'user@student.com',
      prodi: 'D4 Teknik Informatika',
      status: 'Mahasiswa Aktif',
      photoUrl: 'https://ui-avatars.com/api/?name=User+Mahasiswa&background=764ba2&color=fff&size=128',
    );
  }
}