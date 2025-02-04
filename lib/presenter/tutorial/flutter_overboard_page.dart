import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:searchapplication/presenter/search_page.dart';
import 'package:searchapplication/repository/shared_preference_repository.dart';

class FlutterOverboardPage extends StatefulWidget {
  const FlutterOverboardPage({super.key});

  @override
  _FlutterOverboardPageState createState() => _FlutterOverboardPageState();
}

class _FlutterOverboardPageState extends State<FlutterOverboardPage> {
  late Future<bool> initFuture; // ここを Future<bool?> に変更

  @override
  void initState() {
    super.initState();
    // SharedPreferenceRepository().setLunch();
    initFuture = SharedPreferenceRepository().getLunch();
    debugPrint('honda ini $initFuture');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterOverboardPage'),
      ),
      body: FutureBuilder<bool?>(
        future: initFuture,
        builder: (context, snapshot) {
          debugPrint('honda snapshot $snapshot');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            debugPrint('honda snapshot.data ${snapshot.data}');
            final bool isLunch = snapshot.data ?? false; // nullの場合はfalseに設定
            return !isLunch
                ? OverBoard(
                    pages: pages,
                    showBullets: true,
                    skipCallback: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                      SharedPreferenceRepository().setLunch();
                    },
                    finishCallback: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                      SharedPreferenceRepository().setLunch();
                    },
                  )
                : SearchPage();
          }
          return SearchPage();
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
      child: Padding(
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
