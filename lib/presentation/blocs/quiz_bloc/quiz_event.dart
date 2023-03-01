import 'package:equatable/equatable.dart';

import '../../../domain/models/training_info.dart';

abstract class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitWords extends QuizEvent {
  final String currentWord;

  InitWords(this.currentWord);
}

class ChooseAnswer extends QuizEvent {
  final TrainingInfo trainingInfo;

  ChooseAnswer(this.trainingInfo);
}
