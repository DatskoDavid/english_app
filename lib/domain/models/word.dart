import 'dart:math';

import 'package:hive/hive.dart';

part 'word.g.dart';

var random = Random();

@HiveType(typeId: 0)
class Word extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? word;
  @HiveField(2)
  bool? isFavourite;

  Word({
    /* this.id = /* Hive.box('words_box').length.toString() */, */
    this.id = '0',
    required this.word,
    this.isFavourite = false,
  });
}

