import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'letter.dart';

part 'game_board.g.dart';

@JsonSerializable()
class GameBoard {
  static const int maxWordLength = 5;
  static const int maxLineLength = 6;


  GameBoard();

  int currentLine = 0;

  @BoardConverter()
  List<List<Letter>> board =
  List<List<Letter>>.generate(maxLineLength, (int index) => []);

  factory GameBoard.fromJson(Map<String, dynamic> json) => _$GameBoardFromJson(json);

  Map<String, dynamic> toJson() => _$GameBoardToJson(this);

  bool addLetter(Letter letter) {
    if (checkCurrentLineFilled()) {
      return false;
    }
    board[currentLine].add(letter);
    debugPrint(board.join(","));
    return true;
  }

  bool deleteLetter() {
    if (board[currentLine].isEmpty) {
      return false;
    }
    board[currentLine].removeLast();
    return true;
  }

  bool moveNextLine() {
    if (!checkCurrentLineFilled()) {
      return false;
    }
    if (currentLine + 1 >= maxLineLength) {
      // 6回目以降であれば、進まない
      return false;
    }
    currentLine++;
    return true;
  }

  int getCurrentLine() {
    return currentLine;
  }

  List<Letter> getCurrentLineLetters() {
    return getLineLetters(currentLine);
  }

  List<Letter> getLineLetters(int line) {
    return board[line];
  }

  bool checkCurrentLineFilled() {
    return checkLineFilled(currentLine);
  }

  bool checkLineFilled(int line) {
    return getLineLetters(line).length >= maxWordLength;
  }

  List<List<Letter>> takeCurrentLineRows() {
    return board.take(currentLine).toList();
  }

  bool containsTakeCurrentLine(Letter letter) {
    return takeCurrentLineRows().any((rowList) => rowList.contains(letter));
  }
}

class BoardConverter implements JsonConverter<List<List<Letter>>, String> {
  const BoardConverter();

  @override
  List<List<Letter>> fromJson(String json) {
    if (json.isEmpty) {
      return List<List<Letter>>.generate(GameBoard.maxLineLength, (int index) => []);
    }
    return json
        .split(":")
        .map((e) => ListLetterExt.valueOf(e))
        .toList();
  }

  @override
  String toJson(List<List<Letter>> object) {
    return object.map((e) => e.joinedValue).join(":");
  }
}