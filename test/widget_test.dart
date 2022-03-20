import 'package:flutter_test/flutter_test.dart';

import 'package:wordlef/components/play/keyboard.dart';
import 'package:wordlef/components/play/letter_spot.dart';
import 'package:wordlef/main.dart';

void main() {
  testWidgets('Click Letter : Input word', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.widgetWithText(LetterSpot, "E"), findsNothing);
    expect(find.widgetWithText(LetterSpot, "A"), findsNothing);
    expect(find.widgetWithText(LetterSpot, "D"), findsNothing);

    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "A"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "D"));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "E"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "A"), findsOneWidget);
    expect(find.widgetWithText(LetterSpot, "D"), findsOneWidget);
  });

  testWidgets('Click Enter : move to next line', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 最初になにもないところでEnterKeyを押しても問題ないことを確認しておく
    await tester.tap(find.byType(EnterKeyItem));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    // Not input. 1 word length less than equal 5.
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "E"), findsNWidgets(5));

    await tester.tap(find.byType(EnterKeyItem));
    await tester.tap(find.widgetWithText(LetterKeyItem, "E"));
    await tester.pump();

    expect(find.widgetWithText(LetterSpot, "E"), findsNWidgets(6));
  });

  testWidgets('Click Delete : delete letter', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

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
