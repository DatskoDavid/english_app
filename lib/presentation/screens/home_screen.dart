import 'package:flutter/material.dart';

import 'vocabulary_screen.dart';
import 'word_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Vocabulary'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const VocabularyScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Train words'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const WordInfoScreen(word: 'DEFAULT (from main)');
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
