import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/repository/shared_preference_repository.dart';

final sharedPreferenceRepositoryProvider = Provider<SharedPreferenceRepository>((ref) {
  return SharedPreferenceRepository();
});

final firstLaunchNotifier = StateNotifierProvider.autoDispose<FirstLaunchNotifier, bool>((ref) {
  final repository = ref.read(sharedPreferenceRepositoryProvider);
  return FirstLaunchNotifier(repository).._init();
});

class FirstLaunchNotifier extends StateNotifier<bool> {
  final SharedPreferenceRepository repository;

  FirstLaunchNotifier(this.repository) : super(false) {
    _init();
  }

  // 非同期の初期化処理
  Future<void> _init() async {
    try {
      // 非同期処理が完了するのを待つ
      final initialValue = await repository.getLunch();
      state = initialValue;  // 非同期処理が完了したらstateを更新
      debugPrint('honda _init $state');
    } catch (e) {
      debugPrint('honda _init error: $e');
      // エラーハンドリングが必要なら、状態をエラーメッセージなどに設定
      state = false;
    }
  }


  // データを取得する非同期メソッド
  Future<void> getLunch() async {
    try {
      final lunch = await repository.getLunch();
      state = lunch;  // 状態を更新
      debugPrint('honda getLunch $state');
    } catch (e) {
      debugPrint('honda getLunch error: $e');
      // エラーハンドリング
      state = false;
    }
  }

  // データを設定する非同期メソッド
  Future<void> setLunch() async {
    try {
      await repository.setLunch();
      debugPrint('honda setLunch called');
      // 成功した場合、状態を何らかの値に更新することも可能
    } catch (e) {
      debugPrint('honda setLunch error: $e');
    }
  }
}
