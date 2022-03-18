import 'package:flutter/material.dart';
import 'LetterSpot.dart';

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
        LetterSpot("A"),
        LetterSpot("B"),
        LetterSpot("C"),
        LetterSpot("D"),
        LetterSpot("E"),
      ],

    );
  }

}