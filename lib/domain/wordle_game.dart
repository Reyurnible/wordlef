import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'letter.dart';

class WordleGame {
  final List<Letter> answer = [
    Letter.B,
    Letter.O,
    Letter.A,
    Letter.R,
    Letter.D,
  ];
  final GameBoard board = GameBoard();
  GameStatus status = GameStatus.PLAYING;

  void onPressedLetter(Letter letter) {
    if (status != GameStatus.PLAYING) {
      return;
    }
    board.addLetter(letter);
  }

  void onPressedDelete() {
    if (status != GameStatus.PLAYING) {
      return;
    }
    board.deleteLetter();
  }

  bool onPressedEnter() {
    if (status != GameStatus.PLAYING) {
      return false;
    }
    if (board.checkCurrentLineFilled()) {
      // Check answer.
      if (listEquals(answer, board.getCurrentLineLetters())) {
        // Success.
        status = GameStatus.SUCCEED;
        debugPrint("Game Succeed!!!");
      } else {
        // Failure
        if (!board.moveNextLine()) {
          // LOOSE GAME
          status = GameStatus.LOOSED;
          debugPrint("Game Loosed!!!");
        } else {
          debugPrint("Move to next line. (Line: ${board.currentLine})");
        }
      }
      return true;
    } else {
      // Error no filled
      debugPrint("No filled line");
      return false;
    }
  }
}

enum GameStatus {
  PLAYING,
  LOOSED,
  SUCCEED,
}

class GameBoard {
  static const int MAX_LETTER_LENGTH = 5;
  static const int MAX_LINE_LENGTH = 6;

  int currentLine = 0;

  final List<List<Letter>> board =
      List<List<Letter>>.generate(MAX_LINE_LENGTH, (int index) => []);
      // List<List<Letter>>.filled(MAX_LINE_LENGTH, []);

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
    if (currentLine + 1 >= MAX_LINE_LENGTH) {
      // 6回目以降であれば、進まない
      return false;
    }
    currentLine++;
    return true;
  }

  List<Letter> getCurrentLineLetters() {
    return getLineLetters(currentLine);
  }

  List<Letter> getLineLetters(int line) {
    return board[line];
  }

  bool checkCurrentLineFilled() {
    return getCurrentLineLetters().length >= MAX_LETTER_LENGTH;
  }
}

