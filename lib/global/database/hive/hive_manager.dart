import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/global/constants/app_constant.dart';
import 'package:clean_arch/global/utils/file_operation_util.dart';
import 'package:hive_flutter/adapters.dart';

class HiveManager {
  HiveManager(
    this._hive, {
    FileOperationUtil? fileOperationUtil,
  }) : _fileOperationUtil = fileOperationUtil ?? FileOperationUtil();

  final HiveInterface _hive;
  final FileOperationUtil _fileOperationUtil;

  Future<void> init() async {
    await openBox();
    registerAdapter();
  }

  Future<void> openBox() async {
    final subPath =
        await _fileOperationUtil.createSubDirectory(AppConstant.appName);
    await _hive.initFlutter(subPath);
  }

  void registerAdapter() {
    _hive.registerAdapter<ArticleModel>(ArticleModelAdapter());
  }
}
