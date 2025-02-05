import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:provider/provider.dart';
import 'package:searchapplication/presenter/search_page.dart';
import 'package:searchapplication/repository/shared_preference_repository.dart';

class FlutterOverboardPage extends StatelessWidget {
   FlutterOverboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumerを使って、SharedPreferenceRepositoryの状態を監視
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterOverboardPage'),
      ),
      body: Consumer<SharedPreferenceRepository>(
        builder: (context, repository, child) {
          if (repository.isLunch) {
            return const SearchPage();
          } else {
            return OverBoard(
              pages: pages,
              showBullets: true,
              skipCallback: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
                repository.setLunch(); // skip時にもLunch設定
              },
              finishCallback: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
                repository.setLunch(); // finish時にもLunch設定
              },
            );
          }
        },
      ),
    );
  }

  final pages = [
    PageModel(
      color: const Color(0xFF95cedd),
      imageAssetPath: 'assets/0.png',
      title: '文字を表示できます',
      body: '細かい説明をbodyに指定して書くことが出来ます',
      doAnimateImage: true,
    ),
    PageModel(
      color: const Color(0xFF9B90BC),
      imageAssetPath: 'assets/1.png',
      title: '左右のスワイプ',
      body: 'NEXTを押さなくても左右にスワイプすることで画面の切替が出来ます',
      doAnimateImage: true,
    ),
    PageModel.withChild(
      child: const Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Text(
          "さあ、始めましょう",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
      color: const Color(0xFF5886d6),
      doAnimateChild: true,
    ),
  ];
}
