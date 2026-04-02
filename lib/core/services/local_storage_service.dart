import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _savedUsersKey = 'saved_users';

  // --- BAGIAN MANAJEMEN TOKEN ---
  // Simpan token ke memori
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Ambil token dari memori (Ini yang bikin merah tadi)
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Hapus token
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // --- BAGIAN DAFTAR USER TERSIMPAN ---
  Future<void> addUserToSavedList({required String userId, required String username}) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedUsersKey) ?? [];

    final isDuplicate = rawList.any((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    if (isDuplicate) return;

    final newUser = jsonEncode({
      'user_id': userId,
      'username': username,
      'saved_at': DateTime.now().toIso8601String(),
    });

    rawList.add(newUser);
    await prefs.setStringList(_savedUsersKey, rawList);
  }

  Future<List<Map<String, String>>> getSavedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedUsersKey) ?? [];
    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return {
        'user_id': map['user_id'].toString(),
        'username': map['username'].toString(),
        'saved_at': map['saved_at'].toString(),
      };
    }).toList();
  }

  Future<void> clearSavedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedUsersKey);
  }

  Future<void> removeSavedUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedUsersKey) ?? [];
    rawList.removeWhere((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });
    await prefs.setStringList(_savedUsersKey, rawList);
  }
}