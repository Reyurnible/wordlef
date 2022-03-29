import 'package:flutter/material.dart';
import 'package:wordlef/components/play/spot_result_view_ext.dart';

import '../../../domain/model/letter.dart';
import '../../../domain/model/spot_result.dart';
import 'key_item_theme.dart';

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
        child: SizedBox(
          width: KeyItemTheme.letterKeyItemWidth(context),
          height: KeyItemTheme.keyItemHeight,
          child: ElevatedButton(
              child: Text(letter.value,
                  style: _inflateSpotResultTextStyle(spotResult)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(spotResult.color),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: () {
                onPressed.call(letter);
              },
            )
        ),
        margin: KeyItemTheme.margin,
    );
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