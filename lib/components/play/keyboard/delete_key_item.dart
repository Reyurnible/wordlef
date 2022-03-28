import 'package:flutter/material.dart';

import '../keyboard.dart';
import 'key_item_theme.dart';

class DeleteKeyItem extends StatelessWidget {
  const DeleteKeyItem({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
          width: KeyItemTheme.enterDelKeyItemWidth(context),
          height: KeyItemTheme.keyItemHeight,
          child: ElevatedButton(
            child: const Text("DEL",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFD3D6DA)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            onPressed: () {
              onPressed.call();
            },
          ),
        ),
        margin: KeyItemTheme.margin);
  }
}
