import 'package:equatable/equatable.dart';

import '../../../domain/models/training_info.dart';

class QuizState extends Equatable {
  final List<String> variants;

  final List<TrainingInfo> trainingInfoList;

  const QuizState({
    required this.variants,
    required this.trainingInfoList,
  });

  QuizState copyWith({
    List<String>? variants,
    List<TrainingInfo>? trainingInfoList,
  }) =>
      QuizState(
        variants: variants ?? this.variants,
        trainingInfoList: trainingInfoList ?? this.trainingInfoList,
      );

  @override
  List<Object?> get props => [variants];
}
