import 'package:flutter/material.dart';
import 'package:wordlef/domain/letter.dart';
import 'letter_spot.dart';

class WordRow extends StatelessWidget {
  WordRow({
    Key? key,
    this.word = ""
  }) : super(key: key);

  final String word;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LetterSpot(Letter.A),
        LetterSpot(Letter.B),
        LetterSpot(Letter.C),
        LetterSpot(Letter.D),
        LetterSpot(Letter.E),
      ],

    );
  }

}