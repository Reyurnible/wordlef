// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      (json['wordList'] as List<dynamic>)
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..checkUpperWordSet = (json['checkUpperWordSet'] as List<dynamic>)
          .map((e) => e as String)
          .toSet()
      ..answer = (json['answer'] as List<dynamic>)
          .map((e) => $enumDecode(_$LetterEnumMap, e))
          .toList()
      ..board = GameBoard.fromJson(json['board'] as Map<String, dynamic>)
      ..status = $enumDecode(_$GameStatusEnumMap, json['status']);

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'wordList': instance.wordList,
      'checkUpperWordSet': instance.checkUpperWordSet.toList(),
      'answer': instance.answer.map((e) => _$LetterEnumMap[e]).toList(),
      'board': instance.board,
      'status': _$GameStatusEnumMap[instance.status],
    };

const _$LetterEnumMap = {
  Letter.A: 'A',
  Letter.B: 'B',
  Letter.C: 'C',
  Letter.D: 'D',
  Letter.E: 'E',
  Letter.F: 'F',
  Letter.G: 'G',
  Letter.H: 'H',
  Letter.I: 'I',
  Letter.J: 'J',
  Letter.K: 'K',
  Letter.L: 'L',
  Letter.M: 'M',
  Letter.N: 'N',
  Letter.O: 'O',
  Letter.P: 'P',
  Letter.Q: 'Q',
  Letter.R: 'R',
  Letter.S: 'S',
  Letter.T: 'T',
  Letter.U: 'U',
  Letter.V: 'V',
  Letter.W: 'W',
  Letter.X: 'X',
  Letter.Y: 'Y',
  Letter.Z: 'Z',
};

const _$GameStatusEnumMap = {
  GameStatus.loading: 'loading',
  GameStatus.playing: 'playing',
  GameStatus.loosed: 'loosed',
  GameStatus.succeed: 'succeed',
};
