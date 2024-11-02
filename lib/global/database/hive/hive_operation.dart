import 'package:clean_arch/global/database/hive/hive_encryption.dart';
import 'package:clean_arch/global/database/primitive/primitive_database.dart';
import 'package:hive_flutter/adapters.dart';

class HiveOperation<T> {
  Box<T>? _box;
  final String _key = T.toString();

  final HiveInterface _hive;
  late final HiveEncryption encryption;

  HiveOperation(
    this._hive,
    PrimitiveDatabase primitiveDatabase, {
    HiveEncryption? encryption,
  }) : encryption = encryption ?? HiveEncryption(_hive, primitiveDatabase);

  Future<void> startBox() async {
    if (_hive.isBoxOpen(_key)) return;
    final encrytionKey = await encryption.getSecureKey();
    _box = await _hive.openBox(
      _key,
      encryptionCipher: HiveAesCipher(encrytionKey),
    );
  }

  Future<void> insertOrUpdateItem(String key, T model) =>
      _run<void>(() => _box!.put(key, model));

  Future<void> insertOrUpdateItems(List<String> keys, List<T> models) =>
      _run<void>(() async {
        if (keys.length != models.length) {
          throw ArgumentError('Number of keys and models should be the same');
        }

        final map = Map.fromIterables(keys, models);
        await _box!.putAll(map);
      });

  Future<T?> getItem(String key) => _run<T?>(() => _box!.get(key));

  Future<List<T>> getAllItems() => _run<List<T>>(() => _box!.values.toList());

  Future<void> deleteItem(String key) => _run<void>(() => _box!.delete(key));

  Future<void> deleteAllItems() => _run<void>(() => _box!.clear());

  Future<U> _run<U>(U Function() operation) async {
    if (_box == null) await startBox();
    return operation();
  }
}
