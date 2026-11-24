import 'package:exam/config/storage/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthSession {
  final SecureStorageService _secureStorageService;

  AuthSession(this._secureStorageService);

  static const String _tokenKey = 'auth_token';

  String? _sessionToken;

  Future<void> saveToken(String token, {required bool rememberMe}) async {
    _sessionToken = token;

    if (rememberMe) {
      await _secureStorageService.setSecuredString(_tokenKey, token);
    } else {
      await _secureStorageService.deleteSecuredData(_tokenKey);
    }
  }

  Future<String?> getToken() async {
    if (_sessionToken != null) return _sessionToken;

    final token = await _secureStorageService.getSecuredString(_tokenKey);
    _sessionToken = token.isEmpty ? null : token;

    return _sessionToken;
  }

  Future<void> clearToken() async {
    _sessionToken = null;
    await _secureStorageService.deleteSecuredData(_tokenKey);
  }
}
