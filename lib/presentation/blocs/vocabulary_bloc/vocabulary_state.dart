import 'package:equatable/equatable.dart';

import '../../../domain/models/word.dart';

class VocabularyState extends Equatable {
  final List<Word> words;

  const VocabularyState({required this.words});

  VocabularyState copyWith({List<Word>? words}) =>
      VocabularyState(words: words ?? this.words);

  @override
  List<Object?> get props => [words];
}
