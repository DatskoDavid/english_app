import 'package:flutter/material.dart';

import 'vocabulary_screen.dart';
import 'word_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              tileColor: const Color.fromARGB(255, 15, 134, 194),
              hoverColor: Colors.indigo,
              dense: true,
              title: const Center(
                child: Text(
                  'Vocabulary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              tileColor: const Color.fromARGB(255, 15, 134, 194),
              hoverColor: Colors.indigo,
              dense: true,
              title: const Center(
                child: Text(
                  'Train words',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
          ),
        ],
      ),
    );
  }
}
