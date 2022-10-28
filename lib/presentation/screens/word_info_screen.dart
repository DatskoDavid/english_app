import 'package:flutter/material.dart';

import '../../data/get_word_service.dart';
import '../widgets/word_definition_card.dart';
import 'training_mode_screens/quiz_screen.dart';

class WordInfoScreen extends StatefulWidget {
  final String word;

  const WordInfoScreen({super.key, required this.word});

  @override
  State<WordInfoScreen> createState() => _WordInfoScreenState();
}

class _WordInfoScreenState extends State<WordInfoScreen> {
  late final wordService = WordService(widget.word);
  late Future<WordApi> wordFromNetwork = wordService.fetchWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About word'),
      ),
      body: FutureBuilder<WordApi>(
        future: wordFromNetwork,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(constraints.maxHeight * 0.02),
                    child: Column(
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.5,
                          padding: EdgeInsets.all(constraints.maxHeight * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/balancing-stones.jpg',
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    snapshot.data!.word,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  // const Spacer(),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: IconButton(
                                      icon: Icon(Icons.volume_up_outlined),
                                      onPressed: null,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '[ ${snapshot.data!.pronunciation} ]',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.46,
                          child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.results.length,
                            itemBuilder: (_, index) => WordDefinitionCard(
                              result: snapshot.data!.results[index],
                            ),
                            padding: EdgeInsets.only(
                                bottom: constraints.maxHeight * 0.05),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                    height: constraints.maxHeight * 0.07,
                    width: constraints.maxWidth * 0.28,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.5,
                            color: Colors.indigo,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return QuizScreen(word: wordFromNetwork);
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Go study',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Sorry, didn\'t find such word'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
              backgroundColor: Colors.amber,
            ),
          );
        },
      ),
    );
  }
}
