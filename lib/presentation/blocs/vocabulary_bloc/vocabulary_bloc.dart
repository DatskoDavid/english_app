import 'package:bloc/bloc.dart';

import '../../../domain/use_case/get_list_of_words.dart';
import 'vocabulary_event.dart';
import 'vocabulary_state.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  final GetListOfWords getListOfWords;

  VocabularyBloc(this.getListOfWords)
      : super(const VocabularyState(words: [])) {
    on<InitWords>(_init);
  }

  void _init(_, Emitter<VocabularyState> emit) async {
    final words = await getListOfWords.execute();
    emit(state.copyWith(words: words));
  }
}
