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
  GameStatus status = GameStatus.playing;

  void onPressedLetter(Letter letter) {
    if (isEnded()) {
      return;
    }
    board.addLetter(letter);
  }

  void onPressedDelete() {
    if (isEnded()) {
      return;
    }
    board.deleteLetter();
  }

  bool onPressedEnter() {
    if (isEnded()) {
      return false;
    }
    if (board.checkCurrentLineFilled()) {
      // Check answer.
      if (listEquals(answer, board.getCurrentLineLetters())) {
        // Success.
        status = GameStatus.succeed;
        debugPrint("Game Succeed!!!");
      } else {
        // Failure
        if (!board.moveNextLine()) {
          // LOOSE GAME
          status = GameStatus.loosed;
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

  bool isEnded() {
    return status != GameStatus.playing;
  }
}

enum GameStatus {
  playing,
  loosed,
  succeed,
}

class GameBoard {
  static const int maxWordLength = 5;
  static const int maxLineLength = 6;

  int currentLine = 0;

  final List<List<Letter>> board =
      List<List<Letter>>.generate(maxLineLength, (int index) => []);

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
}

