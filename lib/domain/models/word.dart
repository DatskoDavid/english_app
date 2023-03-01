import 'package:equatable/equatable.dart';

//TODO: remake to first variant
/* class Word extends Equatable {
  final int? id;
  final String word;
  final String phonetic;
  final List<Meaning> meanings;

  Word({
    this.id,
    required this.word,
    required this.phonetic,
    required this.meanings,
  });

  Word copyWith({
    int? id,
    String? word,
    String? phonetic,
    List<Meaning>? meanings,
  }) {
    return Word(
      id: id ?? this.id,
      word: word ?? this.word,
      phonetic: phonetic ?? this.phonetic,
      meanings: meanings ?? this.meanings,
    );
  }

  @override
  List<Object?> get props => [id, word, phonetic, meanings];
} */

class Word extends Equatable {
  final String? id;
  final String word;
  final bool isFavourite;

  Word({
    this.id,
    required this.word,
    required this.isFavourite,
  });

  Word copyWith({
    String? id,
    String? word,
    bool? isFavourite,
  }) {
    return Word(
      id: id ?? this.id,
      word: word ?? this.word,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  @override
  List<Object?> get props => [id, word, word, isFavourite];
}
