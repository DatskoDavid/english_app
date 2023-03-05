import 'package:equatable/equatable.dart';

import '../../../domain/models/training_info.dart';

class QuizState extends Equatable {
  final bool isChoosedAnswer;
  final bool isEnterdWord;

  final List<String> variants;
  // final List<TrainingInfo> trainingInfoList;
  final TrainingInfo? trainingInfo;

  const QuizState({
    required this.isChoosedAnswer,
    required this.isEnterdWord,
    required this.variants,
    required this.trainingInfo,
  });

  QuizState copyWith({
    bool? isChoosedAnswer,
    bool? isEnterdWord,
    List<String>? variants,
    TrainingInfo? trainingInfo,
  }) =>
      QuizState(
        isChoosedAnswer: isChoosedAnswer ?? this.isChoosedAnswer,
        isEnterdWord: isEnterdWord ?? this.isEnterdWord,
        variants: variants ?? this.variants,
        trainingInfo: trainingInfo ?? this.trainingInfo,
      );

  @override
  List<Object?> get props => [isChoosedAnswer, variants, trainingInfo];
}
