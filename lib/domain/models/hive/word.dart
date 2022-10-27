import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? word;
  @HiveField(2)
  bool? isFavourite;

  Word({
    this.id = '0',
    required this.word,
    this.isFavourite = false,
  });
}
