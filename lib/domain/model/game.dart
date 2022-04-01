import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:wordlef/domain/model/game_saved_state.dart';

import 'spot_result.dart';
import 'game_board.dart';
import 'game_status.dart';
import 'letter.dart';
import 'word.dart';

class Game {
  Game(this.wordList) {
    checkUpperWordSet = wordList.map((element) => element.word.toUpperCase()).toSet();
  }

  final List<Word> wordList;
  late final Set<String> checkUpperWordSet;
  
  List<Letter> answer = [];
  GameBoard board = GameBoard();
  GameStatus status = GameStatus.loading;

  void start() {
    final Word answerWord = wordList.random();
    answer = answerWord.letterList;
    board = GameBoard();
    status = GameStatus.playing;

    debugPrint("======START GAME======");
    debugPrint("Answer: ${answerWord.word}");
  }

  void restoreState(GameSavedState state) {
    answer = state.answer;
    board = state.board;
    status = state.status;

    debugPrint("======RESTORE GAME======");
    debugPrint("Status: ${state.status}");
    debugPrint("Answer: ${state.answer}");
    debugPrint("Board: ${state.board.currentLine}");
    debugPrint("Board: ${state.board.board}");
  }

  bool onPressedLetter(Letter letter) {
    if (!isPlaying()) {
      return false;
    }
    return board.addLetter(letter);
  }

  bool onPressedDelete() {
    if (!isPlaying()) {
      return false;
    }
    return board.deleteLetter();
  }

  bool onPressedEnter() {
    if (!isPlaying()) {
      return false;
    }
    if (!board.checkCurrentLineFilled()) {
      // Error no filled
      debugPrint("No filled line");
      throw NotEnoughLettersException();
    }
    if (!checkUpperWordSet
        .contains(board.getCurrentLineLetters().joinedValue.toUpperCase())) {
      // Error not in word list
      debugPrint("Not in word list");
      throw NotInWordListException();
    }
    // Check answer.
    if (listEquals(answer, board.getCurrentLineLetters())) {
      // Success.
      status = GameStatus.succeed;
      debugPrint("Game Succeed!!!");
      debugPrint("======END GAME======");
    } else {
      // Failure
      if (!board.moveNextLine()) {
        // LOOSE GAME
        status = GameStatus.loosed;
        debugPrint("Game Loosed!!!");
        debugPrint("======END GAME======");
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
  
  Map<Letter, SpotResult> getLetterWithResult() {
    if (status == GameStatus.loading) {
      return {};
    }
    Map<Letter, SpotResult> result = {};
    for (var letter in Letter.values) {
      if (board.containsTakeCurrentLine(letter)) {
        if (answer.contains(letter)) {
          for(int index = 0; index < answer.length; index++) {
            if (letter != answer[index]) {
              continue;
            }
            Iterable<int> boardIndexList = board.takeCurrentLineRows().map((row) => row.indexOf(letter));
            if (boardIndexList.contains(index)) {
              result[letter] = SpotResult.correctSpot;
            } else if (result[letter] != SpotResult.correctSpot) {
              result[letter] = SpotResult.wrongSpot;
            }
          }
        } else {
          result[letter] = SpotResult.notInWord;
        }
      } else {
        result[letter] = SpotResult.unknown;
      }
    }
    return result;
  }
}

class NotEnoughLettersException implements Exception {}

class NotInWordListException implements Exception {}

extension ListExt<T> on List<T> {
  T random() {
    int randomIndex = Random().nextInt(length);
    return elementAt(randomIndex);
  } 
} 