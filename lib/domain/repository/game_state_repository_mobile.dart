import 'package:wordlef/domain/model/game_saved_state.dart';

import 'game_state_repository.dart';

class GameStateRepository extends IGameStateRepository {
  @override
  void autoSave(OnInactiveGameCallback onInactiveGame) {
    // Nothing
  }

  @override
  GameSavedState? restore() {
    return null;
  }
}
