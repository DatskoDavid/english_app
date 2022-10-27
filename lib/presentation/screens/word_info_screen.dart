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
  late Future<Word> word;

  @override
  void initState() {
    super.initState();
    word = fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About word'),
      ),
      body: FutureBuilder<Word>(
        future: word,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
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
                                Expanded(
                                  child: Text(
                                    snapshot.data!.word,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const IconButton(
                                  icon: Icon(Icons.volume_up_outlined),
                                  onPressed: null,
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
                        height: constraints.maxHeight * 0.38,
                        child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.results.length,
                          itemBuilder: (_, index) => WordDefinitionCard(
                            result: snapshot.data!.results[index],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.07,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return const QuizScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text('Go study')),
                      )
                    ],
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
