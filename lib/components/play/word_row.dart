import 'package:flutter/material.dart';
import 'package:wordlef/domain/letter.dart';
import 'package:wordlef/domain/spot_result.dart';
import 'package:wordlef/domain/wordle_game.dart';
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
        GameBoard.MAX_LETTER_LENGTH, getLetterSpot);
  }

  LetterSpot getLetterSpot(index) {
    return LetterSpot(word.getOrNull(index), spotResult: getSpotResult(index));
  }

  SpotResult getSpotResult(index) {
    if (!showAnswer) {
      return SpotResult.Unknown;
    }
    if (word[index] == answer[index]) {
      return SpotResult.CorrectSpot;
    } else if (answer.contains(word[index])) {
      return SpotResult.WrongSpot;
    } else {
      return SpotResult.NotInWord;
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
