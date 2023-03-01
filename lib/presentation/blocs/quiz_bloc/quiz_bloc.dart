import 'package:bloc/bloc.dart';

import '../../../domain/use_case/generate_random_variants.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GenerateRandomVariants generateRandomVariants;

  QuizBloc(this.generateRandomVariants)
      : super(const QuizState(variants: [], trainingInfoList: [])) {
    on<InitWords>(_init);
    on<OnVariantTap>(_onVaraintTap);
  }

  void _init(InitWords event, Emitter<QuizState> emit) async {
    generateRandomVariants.currentWord = event.currentWord;
    final variants = await generateRandomVariants.randomVariants;

    emit(state.copyWith(variants: variants));
  }

  void _onVaraintTap(OnVariantTap event, Emitter<QuizState> emit) async {
    final answersList = state.trainingInfoList;
    event.trainingInfo;

    emit(
      state.copyWith(trainingInfoList: answersList),
    );
  }
}
