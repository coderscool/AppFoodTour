import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _hasEnteredKey = 'has_entered';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _roleKey = 'role';
  static const String _idKey = 'id';
  static const String _tokenKey = 'token';


  static Future<void> setEnteredApp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasEnteredKey, true);
  }

  static Future<bool> hasEnteredApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasEnteredKey) ?? false;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<String> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey) ?? '';
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idKey) ?? '';
  }

  static Future<String> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? '';
  }

  static Future<void> saveLoginInfo({
    required String role,
    required String token,
    required String id,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_idKey, id);
  }
}
