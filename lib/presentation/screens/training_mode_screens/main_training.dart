/* import 'dart:math';

import 'package:english_app/domain/models/hive/word.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../client/hive_names.dart';

class MainTraining extends StatelessWidget {

  //TODO: 
  // 1. Generate list of random words (5 - from settings)
  // 2. at first 5 quiz, than - 5 input word
  // 3. result screen with all words 

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

      while (variants.length < 3) {
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


  @override
  Widget build(BuildContext context) {
    return Container();
  }
} */