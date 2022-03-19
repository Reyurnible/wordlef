import 'package:flutter/material.dart';
import 'package:wordlef/domain/letter.dart';

class LetterSpot extends StatelessWidget {
  const LetterSpot(this.letter, {
    Key? key,
  }) : super(key: key);

  final Letter? letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.zero,
      ),
      child: Center(
          child: Text(letter?.value ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800
            ),
          )
      )
    );
  }

}