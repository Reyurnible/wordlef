import 'package:flutter/material.dart';
import 'package:wordlef/domain/letter.dart';
import 'package:wordlef/domain/spot_result.dart';

class LetterSpot extends StatelessWidget {
  const LetterSpot(
    this.letter, {
    Key? key,
    this.spotResult = SpotResult.Unknown,
  }) : super(key: key);

  final Letter? letter;
  final SpotResult spotResult;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.all(2),
        decoration: spotResult.boxDecoration,
        child: Center(
            child: Text(
          letter?.value ?? "",
          textAlign: TextAlign.center,
          style: spotResult.textStyle,
        )));
  }
}

extension SpotResultViewExt on SpotResult {
  BoxDecoration get boxDecoration {
    switch (this) {
      case SpotResult.Unknown:
        return BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.zero,
        );
      case SpotResult.CorrectSpot:
        return const BoxDecoration(
          color: Color(0xFF6AAA64),
          border: null,
          borderRadius: BorderRadius.zero,
        );
      case SpotResult.WrongSpot:
        return const BoxDecoration(
          color: Color(0xFFC9B458),
          border: null,
          borderRadius: BorderRadius.zero,
        );
      case SpotResult.NotInWord:
        return const BoxDecoration(
          color: Color(0xFF787C7E),
          border: null,
          borderRadius: BorderRadius.zero,
        );
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case SpotResult.Unknown:
        return const TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800);
      case SpotResult.CorrectSpot:
      case SpotResult.WrongSpot:
      case SpotResult.NotInWord:
        return const TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800);
    }
  }
}
