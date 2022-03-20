import 'package:flutter/material.dart';
import 'package:wordlef/components/play/keyboard.dart';
import 'package:wordlef/domain/wordle_game.dart';

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
  WordleGame _game = WordleGame();

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
              children: inflateBoard(),
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
    setState(() {
      _game.onPressedLetter(letter);
    });
  }

  void onEnterKeyPressed() {
    debugPrint("Pressed: Enter");
    setState(() {
      _game.onPressedEnter();
    });
  }

  void onDeleteKeyPressed() {
    debugPrint("Pressed: Delete");
    setState(() {
      _game.onPressedDelete();
    });
  }

  List<WordRow> inflateBoard() {
    return List<WordRow>.generate(
        GameBoard.MAX_LINE_LENGTH,
        (index) => WordRow(
              _game.board.getLineLetters(index),
              answer: _game.answer,
              showAnswer: _game.board.checkLineFilled(index) &&
                  (index < _game.board.currentLine || _game.isEnded()),
            ));
  }
}
