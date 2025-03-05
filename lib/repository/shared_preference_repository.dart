import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  late SharedPreferences _prefs;

  // 初期化処理を非同期で行う
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // SharedPreferences のインスタンスを初期化するメソッド
  Future<void> _initPrefs() async {
    // 初回のみインスタンス化
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  // ランチ状態を取得する
  Future<bool> getLunch() async {
    // _prefs が初期化されていることを確認
    // if (_prefs == null) {
    //   await initialize();
    // }
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('isFirstLaunch') ?? false;
  }

  // ランチ状態を設定する
  Future<void> setLunch() async {
    if (_prefs == null) {
      await initialize();
    }
    await _prefs.setBool('isFirstLaunch', false);
  }
}
