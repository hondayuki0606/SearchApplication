import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/config.dart';
import 'presenter/tutorial/flutter_overboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await SharedPreferenceRepository().init();
  Config.environment = Flavor.DEVELOP;
  runApp(
    ProviderScope(
      child: const MyApp(),
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
      home: FlutterOverboardPage(),
    );
  }
}