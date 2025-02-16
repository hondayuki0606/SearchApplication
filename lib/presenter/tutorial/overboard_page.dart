import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/presenter/search_page.dart';
import 'package:searchapplication/domain/first_launch_notifier.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class OverboardPage extends ConsumerWidget {
  const OverboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(firstLaunchNotifier);

    return Scaffold(
      appBar: AppBar(title: const Text("FlutterOverboardPage")),
      body: !state
          ? const SearchPage() // 初回起動ではなく、通常の検索ページを表示
          : OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          _updateLaunchFlag(ref);
          Navigator.pushReplacementNamed(context, '/search');
        },
        finishCallback: () {
          _updateLaunchFlag(ref);
          Navigator.pushReplacementNamed(context, '/search');
        },
      ),
    );
  }

  // 初回起動フラグを更新するための関数
  void _updateLaunchFlag(WidgetRef ref) {
    ref.read(firstLaunchNotifier.notifier).setLunch();
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
