import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/presenter/search_page.dart';
import 'package:searchapplication/repository/shared_preference_repository.dart';

class FlutterOverboardPage extends StatelessWidget {
  FlutterOverboardPage({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final sharedPreferenceRepositoryProvider = Provider((ref) => SharedPreferenceRepository());
  @override
  Widget build(BuildContext context) {
    // Obtain shared preferences.
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('FlutterOverboardPage'),
      ),
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          // SKIPが完了したら次の画面に遷移
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        },
        finishCallback: () {
          // Onboardingが完了したら次の画面に遷移
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
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
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/1.png',
        title: '左右のスワイプ',
        body: 'NEXTを押さなくても左右にスワイプすることで画面の切替が出来ます',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              "さあ、始めましょう",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            )),
        color: const Color(0xFF5886d6),
        doAnimateChild: true)
  ];
}