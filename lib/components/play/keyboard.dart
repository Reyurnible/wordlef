import 'package:flutter/material.dart';
import 'package:wordlef/domain/letter.dart';
import 'package:wordlef/domain/spot_result.dart';

import 'keyboard/delete_key_item.dart';
import 'keyboard/enter_key_item.dart';
import 'keyboard/letter_key_item.dart';

class Keyboard extends StatelessWidget {
  static const double minimumKeyItemWidth = 24;
  static const double defaultKeyItemWidth = 36;
  static const double keyItemHeight = 48;

  final List<Letter> topKeyboardItems = [
    Letter.Q,
    Letter.W,
    Letter.E,
    Letter.R,
    Letter.T,
    Letter.Y,
    Letter.U,
    Letter.I,
    Letter.O,
    Letter.P,
  ];
  final List<Letter> middleKeyboardItems = [
    Letter.A,
    Letter.S,
    Letter.D,
    Letter.F,
    Letter.G,
    Letter.H,
    Letter.J,
    Letter.K,
    Letter.L,
  ];
  final List<Letter> bottomKeyboardItems = [
    Letter.Z,
    Letter.X,
    Letter.C,
    Letter.V,
    Letter.B,
    Letter.N,
    Letter.M,
  ];

  Keyboard({
    Key? key,
    required this.letterWithResult,
    required this.onLetterPressed,
    required this.onEnterPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  final Map<Letter, SpotResult> letterWithResult;
  final LetterKeyItemClickCallback onLetterPressed;
  final VoidCallback onEnterPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomItems = [];
    bottomItems.add(EnterKeyItem(onPressed: onEnterPressed));
    bottomItems
        .addAll(bottomKeyboardItems.map((l) => _inflateLetterKeyItem(l)));
    bottomItems.add(DeleteKeyItem(onPressed: onDeletePressed));

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children:
                topKeyboardItems.map((l) => _inflateLetterKeyItem(l)).toList(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: middleKeyboardItems
                .map((l) => _inflateLetterKeyItem(l))
                .toList(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: bottomItems,
          ),
        ]);
  }

  LetterKeyItem _inflateLetterKeyItem(Letter letter) {
    return LetterKeyItem(letter,
        spotResult: letterWithResult[letter] ?? SpotResult.unknown,
        onPressed: onLetterPressed);
  }
}
