import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordlef/domain/model/game.dart';
import 'package:wordlef/domain/model/word.dart';
import 'package:wordlef/domain/repository/game_state_repository.dart';
import 'package:wordlef/domain/repository/word_repository.dart';
import 'package:wordlef/pages/play/play_content.dart';

final gameProvider = FutureProvider((ref) async {
  // Repository インスタンスを取得する
  final repository = ref.watch(wordRepositoryProvider);
  final List<Word> wordList = await repository.fetchWordList();

  return Game(wordList);
});

class PlayPage extends ConsumerWidget {
  const PlayPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Game> game = ref.watch(gameProvider);
    final IGameStateRepository gameStateRepository =
        ref.read(gameStateRepositoryProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "WORDLEF",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              letterSpacing: 4,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: game.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (game) {
            return PlayContent(
              game,
              gameStateRepository: gameStateRepository,
            );
          },
        ));
  }
}
