import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  late SharedPreferences _prefs; // SharedPreferences インスタンスを保持する変数

  SharedPreferenceRepository() {
    _initPrefs();
  }

  // SharedPreferences のインスタンスを初期化するメソッド
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ランチ状態を取得する
  Future<bool> getLunch() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('isFirstLaunch') ?? false;
    // return isFirstLaunch;
  }

  // ランチ状態を設定する
  Future<void> setLunch() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('isFirstLaunch', true);
  }
}
