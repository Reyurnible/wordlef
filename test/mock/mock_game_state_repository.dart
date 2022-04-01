import 'package:wordlef/domain/model/game_saved_state.dart';
import 'package:wordlef/domain/repository/game_state_repository.dart';

class MockGameStateRepository extends IGameStateRepository {
  @override
  void autoSave(OnInactiveGameCallback onInactiveGame) {
    // Not Action
  }

  @override
  GameSavedState? restore() {
    return null;
  }

}