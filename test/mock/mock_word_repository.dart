import 'package:wordlef/domain/model/word.dart';
import 'package:wordlef/domain/repository/word_repository.dart';

class MockWordRepository extends IWordRepository {
  @override
  Future<List<Word>> fetchWordList() {
    return Future.value([
      Word("board", "japanese", "commentary"),
    ]);
  }
}