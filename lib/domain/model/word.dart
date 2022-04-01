import 'package:json_annotation/json_annotation.dart';

import 'letter.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
  final String word;
  final String japanese;
  final String commentary;

  Word(this.word, this.japanese, this.commentary);

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

  List<Letter> get letterList {
    assert(word.length == 5);
    return ListLetterExt.valueOf(word.toUpperCase());
  }
}

class WordList {
  final List<Word> contents;

  WordList(this.contents);

  factory WordList.fromJson(List<dynamic> parsedJson) {
    List<Word> wordList = [];
    wordList = parsedJson.map((i) => Word.fromJson(i)).toList();

    return WordList(wordList);
  }
}
