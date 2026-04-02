import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/models/dosen_model.dart';
import '../../data/repositories/dosen_repository.dart';

final localStorageProvider = Provider((ref) => LocalStorageService());
final dosenRepoProvider = Provider((ref) => DosenRepository());

final savedUsersProvider = FutureProvider<List<Map<String, String>>>((ref) {
  return ref.watch(localStorageProvider).getSavedUsers();
});

class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repo;
  final LocalStorageService _storage;

  DosenNotifier(this._repo, this._storage) : super(const AsyncValue.loading()) {
    loadDosenList(); 
  }

  Future<void> loadDosenList() async { 
    state = const AsyncValue.loading();
    try {
      final data = await _repo.getDosenList();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveSelectedDosen(DosenModel dosen) async {
    await _storage.addUserToSavedList(
      userId: dosen.id.toString(),
      username: dosen.username,
    );
  }

  // Tambahkan fungsi hapus satu per satu agar DosenPage tidak merah
  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedUser(userId);
  }

  // Tambahkan fungsi hapus semua
  Future<void> clearSavedUsers() async {
    await _storage.clearSavedUsers();
  }
}

final dosenNotifierProvider = StateNotifierProvider<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
  return DosenNotifier(ref.watch(dosenRepoProvider), ref.watch(localStorageProvider));
});