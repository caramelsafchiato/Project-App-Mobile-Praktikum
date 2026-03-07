import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

final profileNotifierProvider = FutureProvider<ProfileModel>((ref) async {
  return ref.watch(profileRepositoryProvider).getProfile();
});