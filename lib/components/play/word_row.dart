import 'package:flutter/material.dart';
import 'package:wordlef/domain/letter.dart';
import 'letter_spot.dart';

class WordRow extends StatelessWidget {
  const WordRow(this.word, {Key? key}) : super(key: key);

  final List<Letter> word;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LetterSpot(word.getOrNull(0)),
        LetterSpot(word.getOrNull(1)),
        LetterSpot(word.getOrNull(2)),
        LetterSpot(word.getOrNull(3)),
        LetterSpot(word.getOrNull(4)),
      ],
    );
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
