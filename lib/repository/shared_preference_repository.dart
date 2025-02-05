import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository with ChangeNotifier {
  bool _isLunch = false;

  bool get isLunch => _isLunch;

  Future<void> getLunch() async {
    final prefs = await SharedPreferences.getInstance();
    _isLunch = prefs.getBool('isLunch') ?? false;
    notifyListeners();
  }

  Future<void> setLunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLunch', true);
    _isLunch = true;
    notifyListeners();
  }
}