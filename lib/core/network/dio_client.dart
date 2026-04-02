import 'package:dio/dio.dart';
import '../services/local_storage_service.dart';

class DioClient {
  // Base URL untuk API jsonplaceholder [cite: 100]
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  final Dio _dio;
  final LocalStorageService _localStorage;

  // Constructor untuk inisialisasi Dio dan LocalStorage [cite: 103]
  DioClient({LocalStorageService? localStorage})
      : _localStorage = localStorage ?? LocalStorageService(),
        _dio = Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: const Duration(seconds: 15), // Batas waktu koneksi [cite: 109]
            receiveTimeout: const Duration(seconds: 15), // Batas waktu menerima data [cite: 110]
            headers: {'Accept': 'application/json'}, // Header standar [cite: 111]
          ),
        ) {
    
    // Menambahkan Interceptor untuk manajemen token otomatis [cite: 114-115]
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Mengambil token dari SharedPreferences [cite: 118]
          final token = await _localStorage.getToken();
          if (token != null) {
            // Jika token ada, tambahkan ke header Authorization [cite: 119]
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options); // Lanjut ke request [cite: 120]
        },
        onResponse: (response, handler) {
          return handler.next(response); // Handle respon [cite: 121-122]
        },
        onError: (DioException error, handler) {
          return handler.next(error); // Handle error [cite: 123-124]
        },
      ),
    );
  }

  // Getter untuk mengakses instance dio [cite: 125]
  Dio get dio => _dio;
}