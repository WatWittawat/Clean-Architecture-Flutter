import 'dart:convert';
import 'dart:typed_data';

import 'package:clean_arch/global/database/primitive/primitive_database.dart';
import 'package:clean_arch/global/database/primitive/primitive_keys.dart';
import 'package:hive_flutter/adapters.dart';

class HiveEncryption {
  HiveEncryption(
    this._hive,
    this._primitiveDatabase,
  );

  final HiveInterface _hive;
  final PrimitiveDatabase _primitiveDatabase;

  Uint8List? encrytionKey;

  Future<Uint8List> getSecureKey() async {
    if (encrytionKey != null) {
      return encrytionKey!;
    }

    String? encrytionKeyString =
        await _primitiveDatabase.read<String>(PrimitiveKeys.secureStorageKey);

    if (encrytionKeyString == null) {
      final key = _hive.generateSecureKey();
      await _primitiveDatabase.write(PrimitiveKeys.secureStorageKey,
          data: base64UrlEncode(key));

      encrytionKeyString = await _primitiveDatabase.read<String>(
        PrimitiveKeys.secureStorageKey,
      );

      if (encrytionKeyString == null) {
        throw Exception('Error while generating secure key');
      }
    }
    final encryptionKey = base64Url.decode(encrytionKeyString);
    encrytionKey = encryptionKey;
    return encryptionKey;
  }
}
