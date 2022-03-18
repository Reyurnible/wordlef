import 'package:flutter/material.dart';

class LetterSpot extends StatelessWidget {
  LetterSpot(this.letter, {
    Key? key,
  }) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.zero,
      ),
      child: Center(
          child: Text(letter,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800
            ),
          )
      )
    );
  }

}