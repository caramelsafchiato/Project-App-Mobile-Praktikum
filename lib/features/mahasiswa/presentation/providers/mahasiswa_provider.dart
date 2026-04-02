import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mhsStorageProvider = Provider((ref) => LocalStorageService());
final mhsRepoProvider = Provider((ref) => MahasiswaRepository());

// Provider untuk memantau data yang tersimpan di HP secara offline [cite: 156-160]
final savedMhsProvider = FutureProvider<List<Map<String, String>>>((ref) {
  return ref.watch(mhsStorageProvider).getSavedUsers();
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repo;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repo, this._storage) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repo.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveMahasiswa(MahasiswaModel mhs) async {
    await _storage.addUserToSavedList(
      userId: mhs.id.toString(),
      username: mhs.nama,
    );
  }

  Future<void> deleteSavedMhs(String id) async => await _storage.removeSavedUser(id);
}

final mahasiswaNotifierProvider = StateNotifierProvider<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  return MahasiswaNotifier(ref.watch(mhsRepoProvider), ref.watch(mhsStorageProvider));
});