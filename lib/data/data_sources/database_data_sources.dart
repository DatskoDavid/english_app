import 'package:hive_flutter/hive_flutter.dart';

import '../../client/box_names.dart';
import '../../domain/models/word.dart';
import '../hive_models/word_db.dart';
import '../mappers/word_mapper.dart';

class DatabaseDataSource {
  static late final Box<WordDB> _wordsBox;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(WordDBAdapter());
    _wordsBox = await Hive.openBox<WordDB>(BoxNames.words);
  }

  DatabaseDataSource();

  Future<void> dispose() async {
    await _wordsBox.close();
  }

  Future<Word> addWord(Word word) async {
    final toCreate = WordDB(word: word.word, isFavourite: false);
    final id = await _wordsBox.add(toCreate).toString();
    final created = toCreate.copyWith(id: id);

    await _wordsBox.put(id, created);
    return created.fromHive();
  }

  Future<List<Word>> getWords() async {
    final result = _wordsBox.values;
    return List.generate(
        result.length, (index) => result.elementAt(index).fromHive());
  }

  Future<Word> getConcreteWord(int index) async {
    return _wordsBox.getAt(index)!.fromHive();
  }

  Future<void> deleteWord(String wordId) async {
    final id = int.tryParse(wordId);
    return _wordsBox.delete(id);
  }

  Future<void> updateWord(Word word) async {
    return _wordsBox.put(word.id, word.toHive());
  }
}
