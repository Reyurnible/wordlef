import 'package:flutter/material.dart';
import 'package:wordlef/components/play/spot_result_view_ext.dart';
import 'package:wordlef/domain/model/letter.dart';
import 'package:wordlef/domain/model/spot_result.dart';

class LetterSpot extends StatelessWidget {
  const LetterSpot(
    this.letter, {
    Key? key,
    this.spotResult = SpotResult.unknown,
  }) : super(key: key);

  final Letter? letter;
  final SpotResult spotResult;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 56,
        height: 56,
        margin: const EdgeInsets.all(2),
        decoration: _inflateBoxDecoration(spotResult),
        child: Center(
            child: Text(
          letter?.value ?? "",
          textAlign: TextAlign.center,
          style: _inflateTextStyle(spotResult),
        )));
  }

  BoxDecoration _inflateBoxDecoration(SpotResult spotResult) {
    switch (spotResult) {
      case SpotResult.unknown:
        return BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: letter != null
                  ? const Color(0xFF878A8C)
                  : const Color(0xFFD3D6DA),
              width: 2),
          borderRadius: BorderRadius.zero,
        );
      case SpotResult.correctSpot:
      case SpotResult.wrongSpot:
      case SpotResult.notInWord:
        return BoxDecoration(
          color: spotResult.color,
          border: null,
          borderRadius: BorderRadius.zero,
        );
    }
  }

  TextStyle _inflateTextStyle(SpotResult spotResult) {
    switch (spotResult) {
      case SpotResult.unknown:
        return const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w900,
        );
      case SpotResult.correctSpot:
      case SpotResult.wrongSpot:
      case SpotResult.notInWord:
        return const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w900,
        );
    }
  }
}
