import 'package:flutter/material.dart';
import 'package:wordlef/components/play/keyboard/key_item_theme.dart';

class EnterKeyItem extends StatelessWidget {
  const EnterKeyItem({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
          width: KeyItemTheme.enterDelKeyItemWidth(context),
          height: KeyItemTheme.keyItemHeight,
          child: ElevatedButton(
            child: const Text("ENTER",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color(0xFFD3D6DA)),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
            onPressed: () {
              onPressed.call();
            },
          ),
        ),
        margin: KeyItemTheme.margin);
  }
}
