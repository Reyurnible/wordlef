import 'package:flutter/material.dart';
import 'package:wordlef/domain/game_board.dart';
import 'package:wordlef/domain/letter.dart';
import 'package:wordlef/domain/spot_result.dart';
import 'letter_spot.dart';

class WordRow extends StatelessWidget {
  const WordRow(this.word, {
    Key? key,
    required this.answer,
    this.showAnswer = false,
  }) : super(key: key);

  final List<Letter> word;
  final List<Letter> answer;
  final bool showAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: inflateWord(),
    );
  }

  List<LetterSpot> inflateWord() {
    return List<LetterSpot>.generate(
        GameBoard.maxWordLength, getLetterSpot);
  }

  LetterSpot getLetterSpot(index) {
    return LetterSpot(word.getOrNull(index), spotResult: getSpotResult(index));
  }

  SpotResult getSpotResult(index) {
    if (!showAnswer) {
      return SpotResult.unknown;
    }
    // ゲーム終了時のハンドリングのため
    if (word.length <= index) {
      return SpotResult.unknown;
    }
    if (word[index] == answer[index]) {
      return SpotResult.correctSpot;
    } else if (answer.contains(word[index])) {
      return SpotResult.wrongSpot;
    } else {
      return SpotResult.notInWord;
    }
  }
}

extension ListExt<T> on List<T> {
  T? getOrNull(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    } else {
      return null;
    }
  }
}
