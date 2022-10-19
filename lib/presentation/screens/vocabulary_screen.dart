import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:english_app/presentation/screens/word_info_screen.dart';
import 'package:english_app/presentation/widgets/add_word_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/models/word.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({Key? key}) : super(key: key);

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final String baseUrl =
      'https://www.oxfordlearnersdictionaries.com/definition/english/';

  String currentUrl(String word) => baseUrl + word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Word>('words_box').listenable(),
        builder: (context, Box<Word> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Box is empty'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final currentWord = box.getAt(index);
              return Dismissible(
                key: Key(currentWord!.id!),
                background: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.delete),
                    ],
                  ),
                ),
                onDismissed: (direction) => currentWord.delete(),
                /* background: Container(
                  color: Colors.green,
                  child: const Icon(Icons.favorite_outline),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Icon(Icons.cancel_outlined),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    bool isChecked = currentWord.isFavourite!;
                    currentWord.isFavourite = !isChecked;
                    currentWord.save();
                  } else {
                    currentWord.delete();
                  }
                }, */
                child: ListTile(
                  leading: InkWell(
                    child: (currentWord.isFavourite ?? false)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite),
                    onTap: () {
                      bool isChecked = currentWord.isFavourite!;
                      currentWord.isFavourite = !isChecked;
                      currentWord.save();
                    },
                  ),
                  title: Text(currentWord.word ?? ''),
                  subtitle: InkWell(
                    onTap: () => launchUrl(
                      Uri.parse(
                        currentUrl(currentWord.word ?? baseUrl),
                      ),
                    ),
                    child: Text(
                      'Search in oxford dictionary',
                      style: TextStyle(
                        color: Colors.blue[200],
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.chrome_reader_mode_outlined),
                    onPressed: () => launchUrl(
                      Uri.parse(
                        currentUrl(currentWord.word ?? baseUrl),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return WordInfoScreen(word: currentWord.word!);
                        },
                      ),
                    );
                  },
                ),
              );
            },
            itemCount: box.values.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMyDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Word?> _showMyDialog() async {
    return showDialog<Word>(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return AddWordDialog();
      },
    );
  }
}
