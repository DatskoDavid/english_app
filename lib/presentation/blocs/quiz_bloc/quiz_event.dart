import 'package:equatable/equatable.dart';

import '../../../domain/models/training_info.dart';

abstract class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitVariants extends QuizEvent {
  final String currentWord;

  InitVariants(this.currentWord);
}

class OnVariantTap extends QuizEvent {
  final String choosedVariant;

  OnVariantTap({required this.choosedVariant});
}

class CheckEnteredWord extends QuizEvent {
  final String enteredWord;

  CheckEnteredWord({required this.enteredWord});
}
