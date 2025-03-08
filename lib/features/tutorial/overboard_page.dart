import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:searchapplication/core/notifiers/first_launch_checker_notifier.dart';

class OverboardPage extends ConsumerWidget {
  const OverboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(firstLaunchNotifier);
    // debugPrint("state $state");
    //
    // // stateがtrueになったときに検索ページに遷移するようにする
    // if (state) {
    //   // 画面遷移を遅延させるために、遷移するタイミングを少し遅らせる
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushReplacementNamed(context, '/search');
    //   });
    //
    //   return const SizedBox(); // 遷移中は空のウィジェットを表示
    // }
    debugPrint('honda OverboardPage build');
    // 初回起動時のOverBoard表示
    return Scaffold(
      appBar: AppBar(title: const Text("FlutterOverboardPage")),
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          _updateLaunchFlag(ref);
          _navigateToSearchPage(context);
        },
        finishCallback: () {
          _updateLaunchFlag(ref);
          _navigateToSearchPage(context);
        },
      ),
    );
  }

  // 初回起動フラグを更新するための関数
  void _updateLaunchFlag(WidgetRef ref) {
    ref.read(firstLaunchCheckerNotifier.notifier).setLunch();
  }

  void _navigateToSearchPage(BuildContext context) {
    // 画面遷移時にちらつきを防ぐため、pushReplacementではなく、Navigator.pushReplacementNamedを使う
    Navigator.pushReplacementNamed(context, '/search');
  }
}

final pages = [
  PageModel(
    color: const Color(0xFF95cedd),
    imageAssetPath: 'assets/test1.png',
    title: '文字を表示できます',
    body: '細かい説明をbodyに指定して書くことが出来ます',
    doAnimateImage: true,
  ),
  PageModel(
    color: const Color(0xFF9B90BC),
    imageAssetPath: 'assets/test1.png',
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
