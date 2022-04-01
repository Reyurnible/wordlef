import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:wordlef/domain/model/game_saved_state.dart';

import '../../components/play/game_board_column.dart';
import '../../components/play/keyboard.dart';
import '../../domain/model/game.dart';
import '../../domain/model/game_status.dart';
import '../../domain/model/letter.dart';

class PlayContent extends StatefulWidget {
  const PlayContent(
    this.game, {
    Key? key,
  }) : super(key: key);

  final Game game;

  @override
  State<StatefulWidget> createState() {
    return _PlayContentState();
  }

}

class _PlayContentState extends State<PlayContent> {
  static const _gameStateStorageKey = 'game_state';

  @override
  void initState() {
    super.initState();
    if (UniversalPlatform.isWeb) {
      // Web Tab event active or inactive handling
      // https://stackoverflow.com/questions/68367780/flutter-web-how-to-detect-applifecyclestate-changes
      window.addEventListener('blur', _onWebInactive);
    }
    final savedState = _restoreGameState();
    if (savedState != null) {
      // FIXME GameBoard is not restored.
      widget.game.restoreState(savedState);
      _updateState();
    } else {
      widget.game.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Six tiles
            GameBoardColumn(
              widget.game.board,
              answer: widget.game.answer,
              isGameEnd: widget.game.isEnded(),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("RESTART",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              onPressed: _onRestartPressed,
            ),
            const SizedBox(height: 48),
            // Keyboard
            Keyboard(
              letterWithResult: widget.game.getLetterWithResult(),
              onLetterPressed: _onLetterKeyPressed,
              onEnterPressed: _onEnterKeyPressed,
              onDeletePressed: _onDeleteKeyPressed,
            ),
          ],
        ),
      ),
    );
  }

  void _onLetterKeyPressed(Letter letter) {
    debugPrint("Pressed: ${letter.value}");

    if (widget.game.onPressedLetter(letter)) {
      _updateState();
    }
  }

  void _onEnterKeyPressed() {
    debugPrint("Pressed: Enter");
    try {
      if (widget.game.onPressedEnter()) {
        _updateState();
        switch (widget.game.status) {
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
    if (widget.game.onPressedDelete()) {
      _updateState();
    }
  }

  void _onRestartPressed() {
    debugPrint("Pressed: Refresh");
    widget.game.start();
    _updateState();
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

  void _onWebInactive(Event event) {
    _storeGameState();
  }

  void _storeGameState() {
    if (!UniversalPlatform.isWeb) {
      return;
    }
    final savedState = GameSavedState.fromGame(widget.game);
    window.sessionStorage[_gameStateStorageKey] = jsonEncode(savedState.toJson());
  }

  GameSavedState? _restoreGameState() {
    if (!UniversalPlatform.isWeb) {
      return null;
    }
    if (window.sessionStorage.containsKey(_gameStateStorageKey) &&
        window.sessionStorage[_gameStateStorageKey] != null) {
      final gameJsonMap = jsonDecode(window.sessionStorage[_gameStateStorageKey]!);
      return GameSavedState.fromJson(gameJsonMap);
    } else {
      return null;
    }
  }
}
