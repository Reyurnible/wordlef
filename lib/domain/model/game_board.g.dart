// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameBoard _$GameBoardFromJson(Map<String, dynamic> json) => GameBoard()
  ..currentLine = json['currentLine'] as int
  ..board = const BoardConverter().fromJson(json['board'] as String);

Map<String, dynamic> _$GameBoardToJson(GameBoard instance) => <String, dynamic>{
      'currentLine': instance.currentLine,
      'board': const BoardConverter().toJson(instance.board),
    };
