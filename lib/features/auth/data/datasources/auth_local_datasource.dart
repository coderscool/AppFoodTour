import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveLoginInfo(String role, String token, String id);
  Future<String> getUserId();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
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

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idKey) ?? '';
  }

  static Future<String> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? '';
  }

  Future<void> saveLoginInfo(
    String role,
    String token,
    String id,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_idKey, id);
    await prefs.setBool(_isLoggedInKey, true);
  }

  static Future<void> clearLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
    await prefs.remove(_tokenKey);
    await prefs.remove(_idKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}