import 'package:flutter/material.dart';
import 'package:wordlef/domain/Letter.dart';

class Keyboard extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: topKeyboardItems.map((l) => LetterKeyItem(l)).toList(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: middleKeyboardItems.map((l) => LetterKeyItem(l)).toList(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: bottomKeyboardItems.map((l) => LetterKeyItem(l)).toList(),
          ),
        ]);
  }
}

class LetterKeyItem extends StatelessWidget {
  LetterKeyItem(this.letter, {this.pressedCallback});

  final Letter letter;
  final LetterKeyItemClickCallback? pressedCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
          child: Text(letter.value),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey),
            minimumSize: MaterialStateProperty.all(Size(32, 48)),
            fixedSize: MaterialStateProperty.all(Size(32, 48)),
            padding: MaterialStateProperty.all(EdgeInsets.zero)
          ),
          onPressed: () {
            pressedCallback?.call(letter);
          },
        ),
        margin: EdgeInsets.all(2)
    );
  }
}

typedef LetterKeyItemClickCallback = void Function(Letter letter);

class EnterKeyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class DeleteKeyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
