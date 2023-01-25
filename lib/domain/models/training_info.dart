import '../../data/get_word_service.dart';

class TrainingInfo {
  final WordApi word;
  String? quizChosenAnswer;
  String? inputWordTypedAnswer;

  TrainingInfo({
    required this.word,
    this.quizChosenAnswer,
    this.inputWordTypedAnswer,
  });

  bool get isCorrectQuizAnswer => quizChosenAnswer == word.word;

  bool get isCorrectInputWordAnswer => inputWordTypedAnswer == word.word;

  double get percent {
    if (word.word == quizChosenAnswer && word.word == inputWordTypedAnswer) {
      return 100;
    } else if (word.word == quizChosenAnswer ||
        word.word == inputWordTypedAnswer) {
      return 50;
    } else {
      return 0;
    }
  }

  TrainingInfo copyWith({
    WordApi? word,
    String? quizChosenAnswer,
    String? inputWordTypedAnswer,
  }) {
    return TrainingInfo(
      word: word ?? this.word,
      quizChosenAnswer: quizChosenAnswer ?? this.quizChosenAnswer,
      inputWordTypedAnswer: inputWordTypedAnswer ?? this.inputWordTypedAnswer,
    );
  }
}


/* Map<String, dynamic> trainingInfo = {
  'word': '',
  'quizCorrectAnswer': '',
  'quizChosenAnswer': '',
  'inputWordCorrectAnswer': '',
  'inputWordTypedAnswer': '',
};
 */