import 'dart:math';

import '../../presentation/di/injector.dart';
import '../repositories/word_repository.dart';
import 'get_list_of_words.dart';

class GenerateRandomVariants {
  final WordRepository _wordRepository;
  late String _currentWord;

  GenerateRandomVariants(this._wordRepository);

  Future<List<String>> get randomVariants => generateRandomVariants();

  set currentWord(String word) => _currentWord = word;

  /* List<String> fromFutureToString(List<String> variants) {
    return variants;
  } */

  Future<List<String>> generateRandomVariants() async {
    final random = Random();

    final getListOfWords = i.get<GetListOfWords>();

    final variants = <String>[];

    final words = await getListOfWords.execute();

    final isEnoughWords = words.length >= 4;

    while (variants.length < 3 && isEnoughWords) {
      var randomIndex = random.nextInt(words.length);

      if (!(variants.contains(words[randomIndex].word)) &&
          words[randomIndex].word != _currentWord) {
        variants.add(words[randomIndex].word);
      }
    }

    if (!variants.contains(_currentWord)) {
      variants.add(_currentWord);
    }

    variants.shuffle();
    print('final result: $variants');
    return variants;
  }
}



//TODO: handle NotEnoughWords to generate variants situation
//if dont enough words in vocabulary in order to generate random variants
  /* if (!isEnoughWords) {
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
    } */