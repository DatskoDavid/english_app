import '../../data/data_sources/database_data_sources.dart';
import '../models/word.dart';

//TODO: remake to first variant
/* abstract class WordRepository {
  final DatabaseDataSource datasource;

  WordRepository(this.datasource);

  Future<Either<Failure, Word>> getWord(String word);
} */

class WordRepository {
  final DatabaseDataSource _db;

  WordRepository(this._db);

  Future<List<Word>> getAllWords() async => await _db.getWords();

  Future<Word> getConcreteWord(int index) async => _db.getConcreteWord(index);

  Future<void> update(Word word) async => _db.updateWord(word);

  Future<void> delete(Word word) async => _db.deleteWord(word.id!);

  Future<void> add(Word word) async => _db.addWord(word);
}
