import 'package:hive/hive.dart';

part 'word_db.g.dart';

@HiveType(typeId: 0)
class WordDB extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? word;
  @HiveField(2)
  bool? isFavourite;

  WordDB({
    this.id = '0',
    required this.word,
    this.isFavourite = false,
  });

  WordDB copyWith({
    String? id,
    String? word,
    bool? isFavourite,
  }) {
    return WordDB(
      id: id ?? this.id,
      word: word ?? this.word,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
