import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchapplication/page/search_detail_page.dart';

final List<String> wordList = [
  "Hello",
  "Good morning",
  "Good afternoon",
  "Good evening",
  "Good night",
  "Good bye",
  "Bye",
  "See you later",
];

final onSearchProvider = StateProvider((ref) => false);
final StateProvider<List<int>> searchIndexListProvider =
StateProvider((ref) => []);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SearchPage(),
    );
  }
}

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onSearchNotifier = ref.watch(onSearchProvider.notifier);
    final onSearch = ref.watch(onSearchProvider);
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
          title: onSearch
              ? _searchTextField(ref)
              : const Text("Search"),
          actions: onSearch
              ? [
            IconButton(
                onPressed: () {
                  onSearchNotifier.state = false;
                },
                icon: const Icon(Icons.clear)),
          ]
              : [
            IconButton(
                onPressed: () {
                  onSearchNotifier.state = true;
                  searchIndexListNotifier.state = [];
                },
                icon: const Icon(Icons.search)),
          ]),
      body: onSearch ? _searchListView(ref) : _defaultListView(),
    );
  }

  Widget _searchTextField(WidgetRef ref) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);
    final List<int> searchIndexList = ref.watch(searchIndexListProvider);
    return TextField(
      autofocus: true,
      onChanged: (String text) {
        searchIndexListNotifier.state = [];
        for (int i = 0; i < wordList.length; i++) {
          if (wordList[i].contains(text)) {
            searchIndexListNotifier.state.add(i); // 今回の問題はここ！！！
          }
        }
      },
    );
  }

  Widget _searchListView(WidgetRef ref) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);
    final searchIndexList = ref.watch(searchIndexListProvider);
    return ListView.builder(
        itemCount: searchIndexList.length,
        itemBuilder: (context, int index) {
          index = searchIndexListNotifier.state[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchDetailPage(title: wordList[index])));
              },
              title: Text(wordList[index]),
            ),
          );
        });
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
                      builder: (context) =>
                          SearchDetailPage(title: wordList[index])));
            },
            title: Text(wordList[index]),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 検索ボックス
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.sort,
                    size: 32,
                  ),
                  onPressed: () {},
                ),
                hintText: '検索',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onChanged: (value) {},
              onSubmitted: (value) {},
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
            Image.asset('assets/images/test1.png'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
