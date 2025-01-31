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
    _prefs!.setBool('init', true);
  }

  Future<bool?> getLunch() async {
    return _prefs!.getBool('init');
  }
}