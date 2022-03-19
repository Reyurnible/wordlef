import 'package:flutter/material.dart';
import 'package:wordlef/components/play/keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/play/word_row.dart';
import 'domain/letter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordlef',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const PlayPage(title: 'Wordlef'),
    );
  }
}

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 1),
            // Six tiles
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                WordRow(),
                WordRow(),
                WordRow(),
                WordRow(),
                WordRow(),
                WordRow(),
              ],
            ),
            const Spacer(flex: 1),
            // Keyboard
            Keyboard(
              onLetterPressed: onLetterKeyPressed,
              onEnterPressed: onEnterKeyPressed,
              onDeletePressed: onDeleteKeyPressed,
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void onLetterKeyPressed(Letter letter) {
    debugPrint("Pressed: ${letter.value}");
    Fluttertoast.showToast(
        msg: "Pressed: ${letter.value}",
    );
  }

  void onEnterKeyPressed() {
    debugPrint("Pressed: Enter");
    Fluttertoast.showToast(
      msg: "Pressed: Enter",
    );
  }

  void onDeleteKeyPressed() {
    debugPrint("Pressed: Delete");
    Fluttertoast.showToast(
      msg: "Pressed: Delete",
    );
  }
}
