import 'package:flutter/material.dart';

class SearchDetailPage extends StatelessWidget {
  const SearchDetailPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.waving_hand,color: Colors.amber,size: 50,),
            Text(title, style: const TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
