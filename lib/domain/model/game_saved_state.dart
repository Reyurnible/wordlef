import 'package:json_annotation/json_annotation.dart';

import 'game.dart';
import 'game_board.dart';
import 'game_status.dart';
import 'letter.dart';

part 'game_saved_state.g.dart';

@JsonSerializable()
class GameSavedState {
  factory GameSavedState.fromJson(Map<String, dynamic> json) =>
      _$GameSavedStateFromJson(json);

  Map<String, dynamic> toJson() => _$GameSavedStateToJson(this);

  GameSavedState({
    required this.answer,
    required this.board,
    required this.status,
  });

  final List<Letter> answer;
  final GameBoard board;
  final GameStatus status;

  static GameSavedState fromGame(Game game) {
    return GameSavedState(
      answer: game.answer,
      board: game.board,
      status: game.status,
    );
  }
}
