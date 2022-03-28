import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:wordlef/domain/model/spot_result.dart';

import 'game_board.dart';
import 'game_status.dart';
import 'letter.dart';
import 'word.dart';

class Game {
  late final List<Word> wordList;
  late final Set<String> checkUpperWordSet;
  
  List<Letter> answer = [];
  final GameBoard board = GameBoard();
  GameStatus status = GameStatus.loading;

  void start(List<Word> wordList) {
    this.wordList = wordList;
    checkUpperWordSet =
        wordList.map((element) => element.word.toUpperCase()).toSet();
    final Word answerWord = wordList.random();
    answer = answerWord.letterList;
    debugPrint("Answer: ${answerWord.word}");
    status = GameStatus.playing;
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
  
  Map<Letter, SpotResult> getLetterWithResult() {
    if (status == GameStatus.loading) {
      return {};
    }
    Map<Letter, SpotResult> result = {};
    for (var letter in Letter.values) {
      if (board.containsTakeCurrentLine(letter)) {
        if (answer.contains(letter)) {
          // 正解の場合
          int answerIndex = answer.indexOf(letter);
          assert(answerIndex >= 0);
          Iterable<int> boardIndexList = board.board.map((row) => row.indexOf(letter));
          if (boardIndexList.contains(answerIndex)) {
            result[letter] = SpotResult.correctSpot;
          } else {
            result[letter] = SpotResult.wrongSpot;
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