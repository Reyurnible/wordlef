import 'package:flutter/material.dart';
import 'package:wordlef/domain/letter.dart';

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

  Keyboard({
    Key? key,
    required this.onLetterPressed,
    required this.onEnterPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  final LetterKeyItemClickCallback onLetterPressed;
  final VoidCallback onEnterPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomItems = [];
    bottomItems.add(EnterKeyItem(onPressed: onEnterPressed));
    bottomItems.addAll(bottomKeyboardItems
        .map((l) => LetterKeyItem(l, onPressed: onLetterPressed)));
    bottomItems.add(DeleteKeyItem(onPressed: onDeletePressed));

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: topKeyboardItems
                .map((l) => LetterKeyItem(l, onPressed: onLetterPressed))
                .toList(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: middleKeyboardItems
                .map((l) => LetterKeyItem(l, onPressed: onLetterPressed))
                .toList(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: bottomItems,
          ),
        ]);
  }
}

class LetterKeyItem extends StatelessWidget {
  const LetterKeyItem(this.letter, {Key? key, required this.onPressed})
      : super(key: key);

  final Letter letter;
  final LetterKeyItemClickCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
          child: Text(letter.value),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFFD3D6DA)),
              minimumSize: MaterialStateProperty.all(const Size(36, 48)),
              fixedSize: MaterialStateProperty.all(const Size(36, 48)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
          onPressed: () {
            onPressed.call(letter);
          },
        ),
        margin: const EdgeInsets.all(2));
  }
}

typedef LetterKeyItemClickCallback = void Function(Letter letter);

class EnterKeyItem extends StatelessWidget {
  const EnterKeyItem({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
          child: const Text("ENTER"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFD3D6DA)),
            minimumSize: MaterialStateProperty.all(const Size(54, 48)),
            fixedSize: MaterialStateProperty.all(const Size(54, 48)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          onPressed: () {
            onPressed.call();
          },
        ),
        margin: const EdgeInsets.all(2));
  }
}

class DeleteKeyItem extends StatelessWidget {
  const DeleteKeyItem({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
          child: const Text("DEL"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFD3D6DA)),
            minimumSize: MaterialStateProperty.all(const Size(54, 48)),
            fixedSize: MaterialStateProperty.all(const Size(54, 48)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          onPressed: () {
            onPressed.call();
          },
        ),
        margin: const EdgeInsets.all(2));
  }
}
