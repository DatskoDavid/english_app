import 'package:bloc/bloc.dart';

import '../../../data/get_word_service.dart';
import '../../../domain/models/training_info.dart';
import '../../../domain/use_case/generate_random_variants.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GenerateRandomVariants generateRandomVariants;

  QuizBloc(this.generateRandomVariants)
      : super(
          const QuizState(
            isChoosedAnswer: false,
            isEnterdWord: false,
            variants: [],
            trainingInfo: null,
          ),
        ) {
    on<InitVariants>(_init);
    on<OnVariantTap>(_onVaraintTap);
    on<CheckEnteredWord>(_checkEnteredWord);
  }

  void _init(InitVariants event, Emitter<QuizState> emit) async {
    generateRandomVariants.currentWord = event.currentWord;
    final variants = await generateRandomVariants.randomVariants;

    //TODO: AHTUNG - [REMAKE into get word from usecase]
    final wordFromNetwork = await WordService(event.currentWord).fetchWords();
    final trainingInfo = TrainingInfo(word: wordFromNetwork);

    emit(
      state.copyWith(
        isChoosedAnswer: false,
        isEnterdWord: false,
        variants: variants,
        trainingInfo: trainingInfo,
      ),
    );
  }

  void _onVaraintTap(OnVariantTap event, Emitter<QuizState> emit) async {
    /* //check if already contain trainingInfo 
    if (state.trainingInfoList.contains(event.trainingInfo)) {
      return;
    } */

    // event.trainingInfo.copyWith(quizChosenAnswer: event.choosedVariant);

    final currentTrainingInfo =
        state.trainingInfo!.copyWith(quizChosenAnswer: event.choosedVariant);

    emit(state.copyWith(
        isChoosedAnswer: true, trainingInfo: currentTrainingInfo));
  }

  void _checkEnteredWord(
      CheckEnteredWord event, Emitter<QuizState> emit) async {
    final currentTrainingInfo =
        state.trainingInfo!.copyWith(inputWordTypedAnswer: event.enteredWord);

    emit(state.copyWith(isEnterdWord: true, trainingInfo: currentTrainingInfo));
  }
}
