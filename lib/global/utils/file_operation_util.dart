import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class FileOperationUtil {
  Future<String> createSubDirectory(String path) async {
    try {
      final newDirectory = await _fileDirectory(path);

      if (!newDirectory.existsSync()) {
        await newDirectory.create();
      }

      return newDirectory.path;
    } catch (e) {
      throw Exception('Error creating sub directory: $e');
    }
  }

  Future<bool> removeSubDirectory(String path) async {
    try {
      final newDirectory = await _fileDirectory(path);

      if (newDirectory.existsSync()) {
        await newDirectory.delete();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Directory> _fileDirectory(String path) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final newDirectory = Directory('$appDocPath/$path');
    return newDirectory;
  }
}
