import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/core/data/repositories/shared_preference_repository.dart';

// Provider で Repository を管理
final sharedPreferenceRepositoryProvider = FutureProvider<SharedPreferenceRepository>((ref) {
  return SharedPreferenceRepository();
});

// Notifierのプロバイダー
final firstLaunchCheckerNotifier = StateNotifierProvider<FirstLaunchCheckerNotifier, AsyncValue<bool>>((ref) {
  return FirstLaunchCheckerNotifier(ref);
});

class FirstLaunchCheckerNotifier extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  // コンストラクタで非同期処理を行う
  FirstLaunchCheckerNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchData();
  }
  late SharedPreferenceRepository sharedPreferenceRepository;

  Future<void> fetchData() async {
    try {
      // SharedPreferenceRepository を取得
      sharedPreferenceRepository= await ref.read(sharedPreferenceRepositoryProvider.future);
      await Future.delayed(Duration(seconds: 2));
      await sharedPreferenceRepository.initialize();
      final firstLunch = await sharedPreferenceRepository.getLunch();
      state = AsyncValue.data(firstLunch); // 結果
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // エラー処理
    }
  }
  // データを設定する非同期メソッド
  Future<void> setLunch() async {
    try {
      await sharedPreferenceRepository.setLunch();
      debugPrint('honda setLunch called');
    } catch (e) {
      debugPrint('honda setLunch error: $e');
    }
  }
}
