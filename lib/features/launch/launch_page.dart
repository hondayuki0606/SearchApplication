import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/features/search/search_detail_page.dart';
import 'package:searchapplication/core/data/repositories/shared_preference_repository.dart';

// 単語リスト
final List<String> wordList = [
  "Hello", "Good morning", "Good afternoon", "Good evening", "Good night",
  "Good bye", "Bye", "See you later",
];

// 検索状態を管理するStateNotifierProvider
final onSearchProvider = StateProvider<bool>((ref) => false);

// 検索結果のインデックスリストを管理するStateNotifierProvider
final searchIndexListProvider = StateProvider<List<int>>((ref) => []);

// SharedPreferencesの非同期処理を管理するFutureProvider
final sharedPreferenceRepositoryProvider = FutureProvider<SharedPreferenceRepository>((ref) async {
  return SharedPreferenceRepository();
});


class LaunchPage extends ConsumerWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onSearch = ref.watch(onSearchProvider);
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);

    // SharedPreferencesの非同期読み込み
    ref.watch(sharedPreferenceRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("まずは性別から始めましょう"),
        actions: onSearch
            ? [
          IconButton(
              onPressed: () {
                ref.read(onSearchProvider.notifier).state = false;
                searchIndexListNotifier.state = [];
              },
              icon: const Icon(Icons.clear)),
        ]
            : [
          IconButton(
              onPressed: () {
                ref.read(onSearchProvider.notifier).state = true;
                searchIndexListNotifier.state = [];
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: onSearch ? _searchListView(ref) : _defaultListView(),
    );
  }

  Widget _searchTextField(WidgetRef ref) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);

    return TextField(
      autofocus: true,
      onChanged: (String text) {
        final updatedIndexList = <int>[];

        for (int i = 0; i < wordList.length; i++) {
          if (wordList[i].contains(text)) {
            updatedIndexList.add(i);
          }
        }

        // 検索結果のインデックスリストを更新
        searchIndexListNotifier.state = updatedIndexList;
      },
    );
  }

  Widget _searchListView(WidgetRef ref) {
    final searchIndexList = ref.watch(searchIndexListProvider);
    return ListView.builder(
      itemCount: searchIndexList.length,
      itemBuilder: (context, index) {
        final wordIndex = searchIndexList[index];
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchDetailPage(title: wordList[wordIndex]),
                ),
              );
            },
            title: Text(wordList[wordIndex]),
          ),
        );
      },
    );
  }

  Widget _defaultListView() {
    return ListView.builder(
      itemCount: wordList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchDetailPage(title: wordList[index]),
                ),
              );
            },
            title: Text(wordList[index]),
          ),
        );
      },
    );
  }
}
