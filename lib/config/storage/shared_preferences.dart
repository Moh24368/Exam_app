import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  static late SharedPreferences _prefs;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';
  static String? _sessionToken;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---------- SharedPreferences ----------

  static Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) => _prefs.getString(key);

  static Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int? getInt(String key) => _prefs.getInt(key);

  static Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }

  // ---------- Secure Storage ----------

  static Future<void> setSecuredString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    return await _secureStorage.read(key: key) ?? '';
  }

  static Future<void> clearAllSecuredData() async {
    _sessionToken = null;
    await _secureStorage.deleteAll();
  }

  // ---------- Auth Token ----------

  static Future<void> saveToken(
    String token, {
    required bool rememberMe,
  }) async {
    _sessionToken = token;
    if (rememberMe) {
      await _secureStorage.write(key: _tokenKey, value: token);
    } else {
      await _secureStorage.delete(key: _tokenKey);
    }
  }

  static Future<String?> getToken() async {
    if (_sessionToken != null) return _sessionToken;
    return _secureStorage.read(key: _tokenKey);
  }

  static Future<void> clearToken() async {
    _sessionToken = null;
    await _secureStorage.delete(key: _tokenKey);
  }
}