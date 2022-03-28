import 'package:flutter/material.dart';
import 'package:wordlef/components/play/spot_result_view_ext.dart';

import '../../../domain/letter.dart';
import '../../../domain/spot_result.dart';
import '../keyboard.dart';

class LetterKeyItem extends StatelessWidget {
  const LetterKeyItem(this.letter,
      {Key? key, this.spotResult = SpotResult.unknown, required this.onPressed})
      : super(key: key);

  final Letter letter;
  final SpotResult spotResult;
  final LetterKeyItemClickCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
          child: Text(letter.value,
              style: _inflateSpotResultTextStyle(spotResult)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(spotResult.color),
            minimumSize: MaterialStateProperty.all(const Size(Keyboard.minimumKeyItemWidth, Keyboard.keyItemHeight)),
            fixedSize: MaterialStateProperty.all(const Size(Keyboard.defaultKeyItemWidth, Keyboard.keyItemHeight)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          onPressed: () {
            onPressed.call(letter);
          },
        ),
        margin: const EdgeInsets.all(2));
  }

  TextStyle _inflateSpotResultTextStyle(SpotResult spotResult) {
    switch (spotResult) {
      case SpotResult.unknown:
        return const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600);
      case SpotResult.correctSpot:
      case SpotResult.wrongSpot:
      case SpotResult.notInWord:
        return const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600);
    }
  }
}

typedef LetterKeyItemClickCallback = void Function(Letter letter);