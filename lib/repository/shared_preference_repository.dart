import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository with ChangeNotifier {
  bool _isFirstLaunch = false;
  late SharedPreferences _prefs; // SharedPreferences インスタンスを保持する変数

  bool get isFirstLaunch => _isFirstLaunch;

  SharedPreferenceRepository() {
    _initPrefs();
  }

  // SharedPreferences のインスタンスを初期化するメソッド
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isFirstLaunch = _prefs.getBool('isFirstLaunch') ?? false;
    notifyListeners();
  }

  // ランチ状態を取得する
  Future<void> getLunch() async {
    _isFirstLaunch = _prefs.getBool('isFirstLaunch') ?? false;
    notifyListeners();
  }

  // ランチ状態を設定する
  Future<void> setLunch() async {
    await _prefs.setBool('isFirstLaunch', true);
    _isFirstLaunch = true;
    notifyListeners();
  }
}
