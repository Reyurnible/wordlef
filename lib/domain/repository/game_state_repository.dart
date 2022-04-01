import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordlef/domain/model/game.dart';
import 'package:wordlef/domain/model/game_saved_state.dart';
import 'game_state_repository_mobile.dart' if (dart.library.html) 'game_state_repository_web.dart';

abstract class IGameStateRepository {
  void autoSave(OnInactiveGameCallback onInactiveGame);

  GameSavedState? restore();
}

typedef OnInactiveGameCallback = Game Function();

final gameStateRepositoryProvider = Provider<IGameStateRepository>((ref) => GameStateRepository());
