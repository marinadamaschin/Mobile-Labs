import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/app_data.dart';

class AppRepository {
  final AssetBundle? bundle;

  const AppRepository({this.bundle});

  Future<AppData> load() async {
    final raw =
        await (bundle ?? rootBundle).loadString('assets/data/app_data.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AppData.fromJson(json);
  }
}
