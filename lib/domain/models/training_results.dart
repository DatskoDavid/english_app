import '../../data/get_word_service.dart';

class TrainingResults {
  final WordApi word;
  final QuizResult quizResult;
  final InputWordResult inputWordResult;
  final double percent;

  TrainingResults({
    required this.word,
    required this.quizResult,
    required this.inputWordResult,
  }) : percent = (quizResult.isCorrect && inputWordResult.isCorrect ? 100 : 50);
}

class QuizResult {
  final bool isCorrect;
  final String correctAnswer;
  final String chosenAnswer;

  QuizResult({
    required this.isCorrect,
    required this.correctAnswer,
    required this.chosenAnswer,
  });
}

class InputWordResult {
  final bool isCorrect;
  final String correctAnswer;
  final String typedAnswer;

  InputWordResult({
    required this.isCorrect,
    required this.correctAnswer,
    required this.typedAnswer,
  });
}
