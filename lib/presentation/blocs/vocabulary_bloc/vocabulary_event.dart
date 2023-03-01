import 'package:equatable/equatable.dart';

abstract class VocabularyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitWords extends VocabularyEvent {
  InitWords();
}
