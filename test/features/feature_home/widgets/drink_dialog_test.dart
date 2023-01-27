import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:water_tracker_app/features/feature_home/widgets/drink_dialog.dart';

void main() {
  group('DrinkDialog modal', () {
    testWidgets('Should display drink dialog with title', (widgetTester) async {
      await _pumpDrinkDialog(widgetTester);

      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pumpAndSettle();

      expect(find.text('Add a drink'), findsOneWidget);
      expect(
          find.byKey(const Key('drink_dialog_cancel_button')), findsOneWidget);
    });
    testWidgets(
      'should close drink dialog on cancel button tap',
      (widgetTester) async {
        await _pumpDrinkDialog(widgetTester);

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byKey(const Key('drink_dialog_cancel_button')));
        await widgetTester.pumpAndSettle();

        expect(find.text('Add a drink'), findsNothing);
      },
    );
    testWidgets(
      'should close drink dialog on cancel button tap',
          (widgetTester) async {
        await _pumpDrinkDialog(widgetTester);

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byKey(const Key('drink_dialog_add_button')));
        await widgetTester.pumpAndSettle();

        expect(find.text('Add a drink'), findsNothing);
      },
    );
    testWidgets(
      'should close drink dialog when tapped outside',
          (widgetTester) async {
        await _pumpDrinkDialog(widgetTester);

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();
        await widgetTester.tapAt(const Offset(0, 0));
        await widgetTester.pumpAndSettle();

        expect(find.text('Add a drink'), findsNothing);
      },
    );
  });
}

Future<void> _pumpDrinkDialog(WidgetTester widgetTester) async {
  await widgetTester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: ElevatedButton(
        onPressed: () {
          showDialog(
            context: widgetTester.element(find.byType(ElevatedButton)),
            builder: (context) => const DrinkDialog(),
          );
        },
        child: const Text('Show Dialog'),
      ),
    ),
  ));
}
