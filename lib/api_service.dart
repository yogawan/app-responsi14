import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/users/login',
        data: {'email': email, 'password': password},
      );
      return response.data['token'];
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
    }
  }

  Future<void> register(String email, String username, String password) async {
    try {
      await _dio.post(
        '/users/register',
        data: {
          'email': email,
          'username': username,
          'password': password,
          'role': 'user',
        },
      );
    } catch (e) {
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getProfile(String token) async {
    try {
      final response = await _dio.get(
        '/users/profile',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch profile: ${e.toString()}');
    }
  }
}
