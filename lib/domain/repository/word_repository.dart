import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/word.dart';

abstract class IWordRepository {
  Future<List<Word>> fetchWordList();
}

class WordRepository extends IWordRepository {
  @override
  Future<List<Word>> fetchWordList() async {
    String json = await rootBundle.loadString('assets/word_list.json');
    return WordList.fromJson(jsonDecode(json)).contents;
  }
}

final wordRepositoryProvider = Provider((ref) => WordRepository());

class MockWordRepository extends IWordRepository {
  @override
  Future<List<Word>> fetchWordList() {
    return Future.value([
      Word("board", "japanese", "commentary"),
    ]);
  }
}
