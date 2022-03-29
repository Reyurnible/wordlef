import 'package:flutter/material.dart';
import 'package:wordlef/domain/model/game_board.dart';
import 'package:wordlef/domain/model/letter.dart';

import 'word_row.dart';

class GameBoardColumn extends StatelessWidget {
  const GameBoardColumn(this.board, {
    Key? key,
    required this.answer,
    required this.isGameEnd,
  }) : super(key: key);

  final GameBoard board;
  final List<Letter> answer;
  final bool isGameEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: _inflateBoard(),
    );
  }

  List<WordRow> _inflateBoard() {
    return List<WordRow>.generate(
        GameBoard.maxLineLength,
        (index) => WordRow(
              board.getLineLetters(index),
              answer: answer,
              showAnswer: board.checkLineFilled(index) &&
                  (index < board.getCurrentLine() || isGameEnd),
            ));
  }
}
