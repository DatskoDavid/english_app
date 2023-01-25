import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../client/hive_names.dart';
import '../../../data/get_word_service.dart';
import '../../../domain/models/hive/word.dart';
import '../../../domain/models/training_info.dart';
import '../../widgets/next_screen_btn.dart';
import '../../widgets/quiz_variant.dart';
import 'input_word_screen.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = 'quiz';

  final WordApi word;

  QuizScreen({super.key, required this.word});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late TrainingInfo trainingInfo = TrainingInfo(word: widget.word);

  bool isChoosedAnswer = false;
  // List<String> variants = <String>[];
  //TODO: return to generation
  List<String> variants = <String>[
    /* 'assume',
    'permit',
    'admit',
    'persuade', */
  ];

// TODO : If not enough words in vocabulary use prerecorded list
  void generateRandomVariants() {
    final random = Random();
    final words = Hive.box<Word>(BoxNames.words);
    final currentWord = widget.word.word;

    final isEnoughWords = words.length >= 4;

    //if dont enough words in vocabulary in order to generate random variants
    if (!isEnoughWords) {
      final prerecordedVariantsList = [
        'assume',
        'permit',
        'admit',
        'persuade',
        'leader'
      ];

      //in case if not enough words in vocabulary in order to generate answers
      while (variants.length < 3 && !isEnoughWords) {
        var randomIndex = random.nextInt(prerecordedVariantsList.length);

        if (!(variants.contains(prerecordedVariantsList[randomIndex])) &&
            prerecordedVariantsList[randomIndex] != currentWord) {
          variants.add(prerecordedVariantsList[randomIndex]);
        }
      }
    }

    while (variants.length < 3 && isEnoughWords) {
      var randomIndex = random.nextInt(words.length);

      if (!(variants.contains(words.getAt(randomIndex)!.word)) &&
          words.getAt(randomIndex)!.word != currentWord) {
        variants.add(words.getAt(randomIndex)!.word as String);
      }
    }

    if (!variants.contains(currentWord)) {
      variants.add(currentWord);
    }

    variants.shuffle();
    print('final result: $variants');
  }

  bool isCorrect(String variant) => variant == widget.word.word;

  void showRightAnswer(String choosedAnswer) {
    trainingInfo = trainingInfo.copyWith(quizChosenAnswer: choosedAnswer);

    setState(() {
      isChoosedAnswer = true;
    });
  }

  @override
  void initState() {
    generateRandomVariants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Screen'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 100, 190, 103),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.word.results[0].definition,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return QuizVariant(
                  variant: variants[index],
                  isCorrect: isCorrect(variants[index]),
                  onTapHandler: isChoosedAnswer ? () {} : showRightAnswer,
                  showCorrectAnswer: isChoosedAnswer,
                );
              },
              itemCount: variants.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
            const SizedBox(height: 20),
            NextScreenBtn(
              routeName: InputWordScreen.routeName,
              arguments: trainingInfo,
            ),
          ],
        ),
      ),
    );
  }
}
