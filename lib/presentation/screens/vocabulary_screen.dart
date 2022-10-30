import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../client/hive_names.dart';
import '../../domain/models/hive/word.dart';
import '../widgets/add_word_dialog.dart';
import 'word_info_screen.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({Key? key}) : super(key: key);

  static const routeName = '/vocabulary';

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  static const baseUrl =
      'https://www.oxfordlearnersdictionaries.com/definition/english/';

  String currentUrl(String word) => baseUrl + word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Word>(BoxNames.words).listenable(),
        // ignore: avoid_types_on_closure_parameters
        builder: (context, Box<Word> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Box is empty'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                child: Card(
                  color: const Color.fromARGB(255, 225, 226, 235),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: InkWell(
                      child: (currentWord.isFavourite ?? false)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite),
                      onTap: () {
                        final isChecked = currentWord.isFavourite!;
                        currentWord.isFavourite = !isChecked;
                        currentWord.save();
                      },
                    ),
                    title: Text(currentWord.word ?? ''),
                    subtitle: InkWell(
                      onDoubleTap: () => launchUrl(
                        Uri.parse(
                          currentUrl(currentWord.word ?? baseUrl),
                        ),
                      ),
                      child: const Text(
                        'Search in oxford dictionary',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.chrome_reader_mode_outlined),
                      onPressed: () => Navigator.pushNamed(
                          context, WordInfoScreen.routeName,
                          arguments: currentWord.word),
                    ),
                    onTap: () => Navigator.pushNamed(
                        context, WordInfoScreen.routeName,
                        arguments: currentWord.word),
                  ),
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
