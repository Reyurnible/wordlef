import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wordlef/components/play/keyboard/delete_key_item.dart';
import 'package:wordlef/components/play/keyboard/enter_key_item.dart';
import 'package:wordlef/components/play/keyboard/letter_key_item.dart';
import 'package:wordlef/components/play/letter_spot.dart';
import 'package:wordlef/domain/repository/game_state_repository.dart';
import 'package:wordlef/domain/repository/word_repository.dart';
import 'package:wordlef/main.dart';

import 'mock/mock_game_state_repository.dart';
import 'mock/mock_word_repository.dart';

/// Widget test tips: https://gist.github.com/Esgrima/c0d4bff4b0d3909daf8994410cd659ce
void main() {
  // Remember this runs before EACH test or group
  setUp(() async {
    debugPrint("Before setUp");
    // final TestWidgetsFlutterBinding binding =
    //     TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Click Letter : Input word', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordRepositoryProvider.overrideWithValue(MockWordRepository()),
          gameStateRepositoryProvider.overrideWithValue(MockGameStateRepository()),
        ],
        child: const MyApp(),
      ),
    );

    // Show Loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "E"), findsNothing);
    expect(find.widgetWithText(LetterSpot, "A"), findsNothing);
    expect(find.widgetWithText(LetterSpot, "D"), findsNothing);

    await tester.scrollUntilVisible(find.byType(EnterKeyItem), 100);
    
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "A"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "D"));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "E"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "A"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "D"), findsOneWidget);
  });

  testWidgets('Click Enter : success word', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordRepositoryProvider.overrideWithValue(MockWordRepository()),
          gameStateRepositoryProvider.overrideWithValue(MockGameStateRepository()),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    await tester.scrollUntilVisible(find.byType(EnterKeyItem), 100);

    // 最初になにもないところでEnterKeyを押しても問題ないことを確認しておく
    await tester.tap(find.byType(EnterKeyItem));
    await tester.tap(find.widgetWithText(LetterKeyItem, "B"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "O"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "A"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "R"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "D"));
    // Not input. 1 word length less than equal 5.
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "E"), findsNothing);

    await tester.tap(find.byType(EnterKeyItem));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "E"), findsNothing);
  });

  testWidgets('Click Delete : delete letter', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordRepositoryProvider.overrideWithValue(MockWordRepository()),
          gameStateRepositoryProvider.overrideWithValue(MockGameStateRepository()),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    await tester.scrollUntilVisible(find.byType(EnterKeyItem), 100);

    // 最初になにもないところでDeleteKeyを押しても問題ないことを確認しておく
    await tester.tap(find.byType(DeleteKeyItem));
    await tester.tap(find.widgetWithText(LetterKeyItem, "A"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "B"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "C"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "D"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "A"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "B"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "C"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "D"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "E"), findsOneWidget);

    await tester.tap(find.byType(DeleteKeyItem));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "A"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "B"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "C"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "D"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "E"), findsNothing);

    await tester.tap(find.byType(DeleteKeyItem));
    await tester.tap(find.byType(DeleteKeyItem));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "A"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "B"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "C"), findsNothing);
    expect(find.widgetWithText(LetterSpot, "D"), findsNothing);
    expect(find.widgetWithText(LetterSpot, "E"), findsNothing);
  });
}
