import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService(this._secureStorage);

  Future<void> setSecuredString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String> getSecuredString(String key) async {
    return await _secureStorage.read(key: key) ?? '';
  }

  Future<void> clearAllSecuredData() async {
    await _secureStorage.deleteAll();
  }

  Future<void> deleteSecuredData(String key) async {
    await _secureStorage.delete(key: key);
  }
}
