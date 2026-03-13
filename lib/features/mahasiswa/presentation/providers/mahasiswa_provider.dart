import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mahasiswa_repository.dart';
import '../../data/models/mahasiswa_model.dart';

final mahasiswaRepositoryProvider = Provider((ref) => MahasiswaRepository());

final mahasiswaNotifierProvider = FutureProvider<List<MahasiswaModel>>((ref) async {
  return ref.watch(mahasiswaRepositoryProvider).getMahasiswaList();
});