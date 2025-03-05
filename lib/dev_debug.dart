import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/config.dart';
import 'package:searchapplication/presenter/search_page.dart';
import 'package:searchapplication/domain/first_launch_notifier.dart';
import 'presenter/tutorial/overboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config.environment = Flavor.DEVELOP;
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // `firstLaunchNotifier`の非同期処理を待つ
    // final futureState = ref.watch(firstLaunchNotifier.future);
    // final futureState = ref.watch(asyncBoolNotifierProvider.notifier).fetchData();
    final futureState = ref.watch(asyncBoolNotifierProvider);
    debugPrint('honda MyApp $futureState build');
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: futureState.when(
        // データが読み込まれるまで、ローディングインジケーターを表示
        data: (isFirstLaunch) {
          return isFirstLaunch ? OverboardPage() : SearchPage();
        },
        loading: () {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
        error: (error, stackTrace) {
          // エラー処理
          return Scaffold(
            body: Center(child: Text('エラーが発生しました')),
          );
        },
      ),
      routes: {
        '/overboard': (context) => OverboardPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
