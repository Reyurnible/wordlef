import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wordlef/components/play/keyboard.dart';
import 'package:wordlef/domain/game.dart';
import 'package:wordlef/domain/word.dart';

import 'components/play/word_row.dart';
import 'domain/game_board.dart';
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
  final Game _game = Game();

  @override
  void initState() {
    super.initState();
    _loadWordListFromAssets().then((value) => {_onWordlistLoaded(value)});
  }

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
              children: _inflateBoard(),
            ),
            const Spacer(flex: 1),
            // Keyboard
            Keyboard(
              onLetterPressed: _onLetterKeyPressed,
              onEnterPressed: _onEnterKeyPressed,
              onDeletePressed: _onDeleteKeyPressed,
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void _onLetterKeyPressed(Letter letter) {
    debugPrint("Pressed: ${letter.value}");
    if (_game.onPressedLetter(letter)) {
      _updateState();
    }
  }

  void _onEnterKeyPressed() {
    debugPrint("Pressed: Enter");
    try {
      if (_game.onPressedEnter()) {
        _updateState();
      }
    } on NotFilledWordException {
      _showEnterExceptionToast("Not filled word");
    } on NotInWordListException {
      _showEnterExceptionToast("Not in word list");
    }
  }

  void _onDeleteKeyPressed() {
    debugPrint("Pressed: Delete");
    if (_game.onPressedDelete()) {
      _updateState();
    }
  }

  List<WordRow> _inflateBoard() {
    return List<WordRow>.generate(
        GameBoard.maxLineLength,
        (index) => WordRow(
              _game.board.getLineLetters(index),
              answer: _game.answer,
              showAnswer: _game.board.checkLineFilled(index) &&
                  (index < _game.board.getCurrentLine() || _game.isEnded()),
            ));
  }

  Future<List<Word>> _loadWordListFromAssets() async {
    debugPrint("_loadWordListFromAssets");
    String json = await rootBundle.loadString('assets/word_list.json');
    return WordList.fromJson(jsonDecode(json)).contents;
  }

  void _onWordlistLoaded(List<Word> wordList) {
    debugPrint("onWordlistLoaded");
    setState(() {
      _game.start(wordList);
    });
  }

  void _updateState() {
    setState(() {});
  }

  void _showEnterExceptionToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      webPosition: "center",
      backgroundColor: Colors.black,
      webBgColor: "#000000",
      fontSize: 16.0,
      textColor: Colors.white,
    );
  }
}
