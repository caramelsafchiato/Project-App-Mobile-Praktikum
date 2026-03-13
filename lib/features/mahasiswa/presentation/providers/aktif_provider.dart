import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/aktif_repository.dart';
import '../../data/models/aktif_model.dart';

final aktifRepositoryProvider = Provider((ref) => AktifRepository());

final aktifNotifierProvider = FutureProvider<List<AktifModel>>((ref) async {
  return ref.watch(aktifRepositoryProvider).getPostsAktif();
});