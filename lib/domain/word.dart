import 'package:json_annotation/json_annotation.dart';

// ジェネレートされたクラスからUserクラスのprivateメンバ変数にアクセスするため
part 'word.g.dart';

@JsonSerializable()
class Word {
  final String word;
  final String japanese;
  final String commentary;

  Word(this.word, this.japanese, this.commentary);

  // _$UserFromJsonが生成される
  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  // _$UserToJsonが生成される
  Map<String, dynamic> toJson() => _$WordToJson(this);
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