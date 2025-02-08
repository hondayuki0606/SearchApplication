import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:searchapplication/config.dart';
import 'package:searchapplication/repository/shared_preference_repository.dart';
import 'presenter/tutorial/flutter_overboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config.environment = Flavor.DEVELOP;
  runApp(
    ProviderScope(  // ProviderScope でラップ
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(  // MultiProvider を使って複数のプロバイダーを提供
        providers: [
          // ここで他の Provider を追加する
          ListenableProvider(create: (_) => SharedPreferenceRepository()),
          ListenableProvider(create: (_) => SharedPreferenceRepository()),
        ],
        child: FlutterOverboardPage(),  // SearchPage を子ウィジェットとして表示
      ),
    );
  }
}
