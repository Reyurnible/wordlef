import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordlef/domain/model/game.dart';
import 'package:wordlef/domain/model/word.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wordlef"),
      ),
      body: game.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (game) {
          return PlayContent(game);
        },
    ));
  }
}

