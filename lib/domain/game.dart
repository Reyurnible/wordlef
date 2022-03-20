import 'package:flutter/foundation.dart';

import 'game_board.dart';
import 'game_status.dart';
import 'letter.dart';
import 'word.dart';

class Game {
  final List<Letter> answer = [
    Letter.B,
    Letter.O,
    Letter.A,
    Letter.R,
    Letter.D,
  ];
  late final List<Word> wordList;
  late final Set<String> checkUpperWordSet;

  final GameBoard board = GameBoard();
  GameStatus status = GameStatus.loading;

  void start(List<Word> wordList) {
    this.wordList = wordList;
    checkUpperWordSet =
        wordList.map((element) => element.word.toUpperCase()).toSet();

    status = GameStatus.playing;
  }

  void onPressedLetter(Letter letter) {
    if (!isPlaying()) {
      return;
    }
    board.addLetter(letter);
  }

  void onPressedDelete() {
    if (!isPlaying()) {
      return;
    }
    board.deleteLetter();
  }

  bool onPressedEnter() {
    if (!isPlaying()) {
      return false;
    }
    if (!board.checkCurrentLineFilled()) {
      // Error no filled
      debugPrint("No filled line");
      return false;
    }
    if (!checkUpperWordSet
        .contains(board.getCurrentLineLetters().joinedValue.toUpperCase())) {
      // Error not in word list
      debugPrint("Not in word list");
      return false;
    }
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
  }

  bool isPlaying() {
    return status == GameStatus.playing;
  }

  bool isEnded() {
    return status == GameStatus.succeed || status == GameStatus.loosed;
  }
}
