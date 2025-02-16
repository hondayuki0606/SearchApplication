import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/config.dart';
import 'package:searchapplication/presenter/search_page.dart';
import 'presenter/tutorial/overboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config.environment = Flavor.DEVELOP;
  runApp(
    ProviderScope(
      // ProviderScope でラップ
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
      initialRoute: '/overboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/overboard': (context) => OverboardPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
