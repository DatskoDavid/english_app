import '../models/word.dart';
import '../repositories/word_repository.dart';

class GetConcreteWord {
  final WordRepository wordRepository;

  GetConcreteWord(this.wordRepository);

  Future<Word> execute({
    required int index,
  }) async {
    return await wordRepository.getConcreteWord(index);
  }
}
