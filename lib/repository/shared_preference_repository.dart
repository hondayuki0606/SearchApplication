import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  static SharedPreferences? _prefs;

  factory SharedPreferenceRepository() =>
      SharedPreferenceRepository._internal();

  SharedPreferenceRepository._internal();

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setLunch() async {
    debugPrint('honda setLunch');
    _prefs?.setBool('init', true);
  }

  Future<bool> getLunch() async {
    debugPrint('honda getLunch');
    return _prefs?.getBool('init') ?? false;
  }
}