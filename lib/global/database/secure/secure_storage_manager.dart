import 'package:clean_arch/global/database/primitive/primitive_database.dart';
import 'package:clean_arch/global/database/primitive/primitive_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager implements PrimitiveDatabase {
  final FlutterSecureStorage _secureStorage;

  SecureStorageManager(this._secureStorage);

  @override
  Future<T?> read<T>(PrimitiveKeys key) async {
    final response = await _secureStorage.read(key: key.name);
    if (response == null || response.isEmpty) {
      return null;
    }

    return response as T;
  }

  @override
  Future<bool> write<T>(PrimitiveKeys key, {required T data}) async {
    try {
      await _secureStorage.write(key: key.name, value: data.toString());
      return true;
    } catch (e) {
      return false;
    }
  }
}
