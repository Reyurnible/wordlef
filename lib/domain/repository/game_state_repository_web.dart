import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:wordlef/domain/model/game.dart';
import 'package:wordlef/domain/model/game_saved_state.dart';

import 'game_state_repository.dart';


class GameStateRepository extends IGameStateRepository {
  static const _gameStateStorageKey = 'game_state';

  @override
  void autoSave(OnInactiveGameCallback onInactiveGame) {
    if (UniversalPlatform.isWeb) {
      // Web Tab event active or inactive handling
      // https://stackoverflow.com/questions/68367780/flutter-web-how-to-detect-applifecyclestate-changes
      window.addEventListener('blur', (event) {
        debugPrint("onInactive");
        _storeGameState(onInactiveGame());
      });
    }
  }

  @override
  GameSavedState? restore() {
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

  void _storeGameState(Game game) {
    if (!UniversalPlatform.isWeb) {
      return;
    }
    final savedState = GameSavedState.fromGame(game);
    window.sessionStorage[_gameStateStorageKey] = jsonEncode(savedState.toJson());
  }
}