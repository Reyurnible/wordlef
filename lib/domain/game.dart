import 'package:flutter/foundation.dart';

import 'game_board.dart';
import 'game_status.dart';
import 'letter.dart';

class Game {
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
          debugPrint("Move to next line. (Current: ${board.getCurrentLine()})");
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

