import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wordlef/components/play/keyboard.dart';
import 'package:wordlef/domain/model/game.dart';
import 'package:wordlef/domain/model/word.dart';

import '../components/play/game_board_column.dart';
import '../domain/model/game_status.dart';
import '../domain/model/letter.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  final String title = "Wordlef";

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
            GameBoardColumn(
              _game.board,
              answer: _game.answer,
              isGameEnd: _game.isEnded(),
            ),
            const Spacer(flex: 1),
            // Keyboard
            Keyboard(
              letterWithResult: _game.getLetterWithResult(),
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
        switch (_game.status) {
          case GameStatus.succeed:
            _showSucceedExceptionToast();
            break;
          case GameStatus.loosed:
            _showLoosedExceptionToast();
            break;
          case GameStatus.loading:
          case GameStatus.playing:
          // Not in action.
            break;
        }
      }
    } on NotEnoughLettersException {
      _showEnterExceptionToast("Not enough letters");
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

  void _showSucceedExceptionToast() {
    Fluttertoast.showToast(
      msg: "SUCCESS",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      webPosition: "center",
      backgroundColor: Colors.blue,
      webBgColor: "#2196F3",
      fontSize: 16.0,
      textColor: Colors.white,
    );
  }

  void _showLoosedExceptionToast() {
    Fluttertoast.showToast(
      msg: "LOOSED",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      webPosition: "center",
      backgroundColor: Colors.deepOrangeAccent,
      webBgColor: "#FF6E40",
      fontSize: 16.0,
      textColor: Colors.white,
    );
  }
}
