import '../models/word.dart';
import '../repositories/word_repository.dart';

class GetListOfWords {
  final WordRepository wordRepository;

  GetListOfWords(this.wordRepository);

  Future<List<Word>> execute() async {
    return await wordRepository.getAllWords();
  }
}
