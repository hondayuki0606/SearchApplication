import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/core/data/repositories/shared_preference_repository.dart';

final sharedPreferenceRepositoryProvider = FutureProvider<SharedPreferenceRepository>((ref) {
  return SharedPreferenceRepository();
});

final firstLaunchCheckerNotifier = StateNotifierProvider<FirstLaunchCheckerNotifier, AsyncValue<bool>>((ref) {
  return FirstLaunchCheckerNotifier(ref);
});

class FirstLaunchCheckerNotifier extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  SharedPreferenceRepository? sharedPreferenceRepository;

  // コンストラクタで非同期処理を行う
  FirstLaunchCheckerNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initialize();  // 初期化処理の開始
  }

  // 初期化処理: SharedPreferenceRepository を非同期で取得する
  Future<void> _initialize() async {
    try {
      final sharedPreferences = await ref.read(sharedPreferenceRepositoryProvider.future);
      sharedPreferenceRepository = sharedPreferences;
      // 初期化後にデータ取得
      await fetchData();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // 初期化エラー処理
    }
  }

  // データ取得処理
  Future<void> fetchData() async {
    if (sharedPreferenceRepository == null) return;
    try {
      await sharedPreferenceRepository!.initialize();
      final firstLaunch = await sharedPreferenceRepository!.getLunch();
      state = AsyncValue.data(firstLaunch); // 結果を state に設定
    } catch (e, stackTrace) {
      // エラー処理
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // データを設定する非同期メソッド
  Future<void> setLunch() async {
    try {
      // データを設定
      await sharedPreferenceRepository?.setLunch();
      debugPrint('setLunch called');
    } catch (e, stackTrace) {
      // エラー発生時のログ出力
      debugPrint('setLunch error: $e\n$stackTrace');
    }
  }
}
