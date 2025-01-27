import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  static SharedPreferences? _prefs;

  factory SharedPreferenceRepository() =>
      SharedPreferenceRepository._internal();

  SharedPreferenceRepository._internal();

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
}

// RiverPodで使う用
final sharedPreferenceRepositoryProvider =
Provider((ref) => SharedPreferenceRepository());