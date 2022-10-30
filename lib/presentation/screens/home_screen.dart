import 'package:flutter/material.dart';

import 'vocabulary_screen.dart';
import 'word_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English App'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        children: [
          _getButton('Vocabulary', context, VocabularyScreen.routeName),
          _getButton('Training words', context, WordInfoScreen.routeName),
        ],
      ),
    );
  }

  Widget _getButton(name, context, routeName) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        tileColor: const Color.fromARGB(255, 124, 192, 226),
        hoverColor: const Color.fromARGB(255, 43, 158, 216),
        dense: true,
        title: Center(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        onTap: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }
}
