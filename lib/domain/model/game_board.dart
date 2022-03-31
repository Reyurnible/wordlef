import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'letter.dart';

part 'game_board.g.dart';

@JsonSerializable()
class GameBoard {
  static const int maxWordLength = 5;
  static const int maxLineLength = 6;

  GameBoard();

  int _currentLine = 0;

  final List<List<Letter>> board =
  List<List<Letter>>.generate(maxLineLength, (int index) => []);

  factory GameBoard.fromJson(Map<String, dynamic> json) => _$GameBoardFromJson(json);

  Map<String, dynamic> toJson() => _$GameBoardToJson(this);

  bool addLetter(Letter letter) {
    if (checkCurrentLineFilled()) {
      return false;
    }
    board[_currentLine].add(letter);
    debugPrint(board.join(","));
    return true;
  }

  bool deleteLetter() {
    if (board[_currentLine].isEmpty) {
      return false;
    }
    board[_currentLine].removeLast();
    return true;
  }

  bool moveNextLine() {
    if (!checkCurrentLineFilled()) {
      return false;
    }
    if (_currentLine + 1 >= maxLineLength) {
      // 6回目以降であれば、進まない
      return false;
    }
    _currentLine++;
    return true;
  }

  int getCurrentLine() {
    return _currentLine;
  }

  List<Letter> getCurrentLineLetters() {
    return getLineLetters(_currentLine);
  }

  List<Letter> getLineLetters(int line) {
    return board[line];
  }

  bool checkCurrentLineFilled() {
    return checkLineFilled(_currentLine);
  }

  bool checkLineFilled(int line) {
    return getLineLetters(line).length >= maxWordLength;
  }

  List<List<Letter>> takeCurrentLineRows() {
    return board.take(_currentLine).toList();
  }

  bool containsTakeCurrentLine(Letter letter) {
    return takeCurrentLineRows().any((rowList) => rowList.contains(letter));
  }
}

