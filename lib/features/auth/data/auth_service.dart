import 'dart:convert';
import 'package:appfoodtour/features/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:7275'; // Đổi thành API thật của bạn

  static Future<String?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/sign-in?username=$username&password=$password');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final id = data['id'];
      final token = data['token'];
      final role = data['role'];
      await LocalStorageService.saveLoginInfo(role: role, token: token, id: id);
      return role;
    } else {
      return null; // Hoặc throw exception
    }
  }
}
