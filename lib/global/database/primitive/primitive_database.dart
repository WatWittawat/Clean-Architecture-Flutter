import 'package:clean_arch/global/database/primitive/primitive_keys.dart';

abstract class PrimitiveDatabase {
  Future<T?> read<T>(PrimitiveKeys key);
  Future<bool> write<T>(PrimitiveKeys key, {required T data});
}
