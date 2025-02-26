import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/repository/shared_preference_repository.dart';

// Provider で Repository を管理
final sharedPreferenceRepositoryProvider = Provider<SharedPreferenceRepository>((ref) {
  return SharedPreferenceRepository();
});

// FirstLaunchNotifier の StateNotifierProvider を定義
final firstLaunchNotifier = StateNotifierProvider.autoDispose<FirstLaunchNotifier, bool>((ref) {
  final repository = ref.read(sharedPreferenceRepositoryProvider);
  return FirstLaunchNotifier(repository);
});

class FirstLaunchNotifier extends StateNotifier<bool> {
  final SharedPreferenceRepository repository;

  // コンストラクタで非同期処理を行う
  FirstLaunchNotifier(this.repository) : super(false) {
    _init();
  }

  // 非同期の初期化処理
  Future<void> _init() async {
    try {
      await repository.initialize();
      final initialValue = await repository.getLunch();  // 非同期で初期値を取得
      state = initialValue;  // 非同期処理が完了したらstateを更新
      debugPrint('honda _init $state called');
    } catch (e) {
      debugPrint('honda _init error: $e');
      state = false;  // エラーが発生した場合はfalseに設定
    }
  }

  // データを取得する非同期メソッド
  Future<void> getLunch() async {
    try {
      final lunch = await repository.getLunch();  // 非同期で取得
      state = lunch;  // 状態を更新
      debugPrint('honda getLunch $state called');
    } catch (e) {
      debugPrint('honda getLunch error: $e');
      state = false;  // エラーハンドリング
    }
  }

  // データを設定する非同期メソッド
  Future<void> setLunch() async {
    try {
      await repository.setLunch();  // 非同期で設定
      debugPrint('honda setLunch called');
    } catch (e) {
      debugPrint('honda setLunch error: $e');
    }
  }
}
