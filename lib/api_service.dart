import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000',
  ));

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post('/users/login', data: {
        'email': email,
        'password': password,
      });
      return response.data['token'];
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<List<dynamic>> fetchProducts(String token) async {
    try {
      final response = await _dio.get('/products',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }
}
