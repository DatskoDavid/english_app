import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/data_sources/database_data_sources.dart';
import '../../domain/models/word.dart';
import '../../domain/use_case/get_list_of_words.dart';
import '../di/injector.dart';
import '../widgets/add_word_dialog.dart';
import '../blocs/vocabulary_bloc/vocabulary_bloc.dart';
import '../blocs/vocabulary_bloc/vocabulary_event.dart';
import '../blocs/vocabulary_bloc/vocabulary_state.dart';
import 'word_info_screen.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({Key? key}) : super(key: key);

  static const routeName = '/vocabulary';

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  late final VocabularyBloc _bloc;

  static const baseUrl =
      'https://www.oxfordlearnersdictionaries.com/definition/english/';

  String currentUrl(String word) => baseUrl + word;

  @override
  void initState() {
    _bloc = i.get<VocabularyBloc>()..add(InitWords());
    super.initState();
  }

  List<Word> justForTest = [
    Word(id: 'dcvdfv', word: 'any word', isFavourite: true),
  ];

  final getListOfWords = i.get<GetListOfWords>();

  void convertList() async {
    final words = await getListOfWords.execute();
    justForTest = await words;
  }

  @override
  Widget build(BuildContext context) {
    DatabaseDataSource.initializeHive();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
      ),
      body: BlocBuilder<VocabularyBloc, VocabularyState>(
        bloc: _bloc,
        builder: (context, state) {
          final words = state.words;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: words.length,
            itemBuilder: (context, index) {
              var currentWord = words[index];

              return Dismissible(
                key: UniqueKey(),
                // key: Key(currentWord!.id!),
                background: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.delete),
                    ],
                  ),
                ),
                // onDismissed: (direction) => currentWord.delete(),
                child: Card(
                  color: const Color.fromARGB(255, 225, 226, 235),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    /* leading: const SizedBox(
                                height: 20,
                                child: LikeButton(),
                              ), */
                    leading: InkWell(
                      child: (currentWord.isFavourite)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite),
                      onTap: () {
                        final isChecked = currentWord.isFavourite;
                        // currentWord.isFavourite = !isChecked;
                        currentWord =
                            currentWord.copyWith(isFavourite: !isChecked);
                        //TODO: make update word in database via update usecase
                        // currentWord.save();
                      },
                    ),
                    title: Text(currentWord.word),
                    subtitle: InkWell(
                      onDoubleTap: () => launchUrl(
                        Uri.parse(
                          currentUrl(currentWord.word),
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
                      context,
                      WordInfoScreen.routeName,
                      arguments: currentWord.word,
                    ),
                  ),
                ),
              );
            },
            /*  itemCount: box.values.length,
                    );
            },
          );
        },
      ), */
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
