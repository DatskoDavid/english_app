import 'package:get_it/get_it.dart';

import '../../data/data_sources/database_data_sources.dart';
import '../../domain/repositories/word_repository.dart';
import '../../domain/use_case/generate_random_variants.dart';
import '../../domain/use_case/get_concrete_word.dart';
import '../../domain/use_case/get_list_of_words.dart';
import '../blocs/quiz_bloc/quiz_bloc.dart';
import '../blocs/vocabulary_bloc/vocabulary_bloc.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  _initDataSources();
  _initRepositories();
  _initUsecases();
  _initBlocs();
}

void _initDataSources() {
  i.registerSingleton<DatabaseDataSource>(DatabaseDataSource());
}

void _initRepositories() {
  i.registerSingleton<WordRepository>(WordRepository(i.get()));
}

void _initUsecases() {
  i.registerSingleton<GetConcreteWord>(GetConcreteWord(i.get()));
  i.registerSingleton<GetListOfWords>(GetListOfWords(i.get()));

  // TODO: set here right answer
  i.registerSingleton<GenerateRandomVariants>(GenerateRandomVariants(i.get()));
}

void _initBlocs() {
  i.registerSingleton<VocabularyBloc>(VocabularyBloc(i.get()));
  i.registerSingleton<QuizBloc>(QuizBloc(i.get()));
}
