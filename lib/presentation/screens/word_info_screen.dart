import 'package:flutter/material.dart';

import '../../data/get_word_service.dart';
import '../widgets/word_definition_card.dart';
import 'training_mode_screens/quiz_screen.dart';

class WordInfoScreen extends StatefulWidget {
  static const routeName = '/word_info';

  final String word;

  const WordInfoScreen({super.key, required this.word});

  @override
  State<WordInfoScreen> createState() => _WordInfoScreenState();
}

class _WordInfoScreenState extends State<WordInfoScreen> {
  late final wordFromNetwork = WordService(widget.word).fetchWords();
  bool lastItem = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About word'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<WordApi>(
          future: wordFromNetwork,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final simpleWord = snapshot.data;
              return Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    /* padding: EdgeInsets.only(
                      top: 1.h,
                      right: 3.w,
                      bottom: 0,
                      left: 3.w,
                    ), */
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                      bottom: 0,
                      left: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          padding: const EdgeInsets.all(10),
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
                          height: MediaQuery.of(context).size.height * 0.47,
                          child: ListView.builder(
                            // shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.results.length,
                            itemBuilder: (_, index) {
                              if (index == snapshot.data!.results.length - 1) {
                                lastItem = true;
                              } else {
                                lastItem = false;
                              }
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: /* lastItem ? 100 : */ 0),
                                child: WordDefinitionCard(
                                  result: snapshot.data!.results[index],
                                ),
                              );
                            },
                            padding:
                                EdgeInsets.only(bottom: lastItem ? 100 : 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: SizedBox(
                  height: 50,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 1.5,
                          color: Colors.indigo,
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        QuizScreen.routeName,
                        arguments: simpleWord,
                      ),
                      child: const FittedBox(
                        child: Text(
                          'Go study',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
      ),
    );
  }
}
