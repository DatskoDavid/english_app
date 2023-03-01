import '../../domain/models/word.dart';
import '../hive_models/word_db.dart';

//TODO: remake to first variant
/* extension WordMapper on WordDB {
  Word fromHive() {
    return Word(id: id, word: word, phonetic: phonetic, meanings: meanings);
  }
}

extension WordDbMapper on Word {
  Word toHive() {
    return Word(id: id, word: word, phonetic: phonetic, meanings: meanings);
  }
} */

extension WordMapper on WordDB {
  Word fromHive() {
    return Word(id: id, word: word!, isFavourite: isFavourite!);
  }
}

extension WordDbMapper on Word {
  WordDB toHive() {
    return WordDB(id: id, word: word, isFavourite: isFavourite);
  }
}
