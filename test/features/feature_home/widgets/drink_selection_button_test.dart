import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:water_tracker_app/features/feature_home/widgets/drink_selection_button.dart';

void main() {
  group('DrinkSelectionButton', () {
    testWidgets('renders correctly', (tester) async {
      await _pumpWidget(tester, (_) {});
      expect(find.byType(DropdownButton<String>), findsOneWidget);
      expect(find.byType(DropdownMenuItem<String>), findsNWidgets(8));
    });

    testWidgets('Displays correct value depends on provided', (tester) async {
      await _pumpWidget(tester, (_) {}, selectedDrink: 'Coffee');
      final dropdown = tester.widget(find.byType(DropdownButton<String>))
          as DropdownButton<String>;
      expect(dropdown.value, 'Coffee');
    });

    testWidgets('Should scroll until last element is visible', (tester) async {
      String selectedDrink = 'Water';
      await _pumpWidget(tester, (val) {
        selectedDrink = val ?? '';
      }, selectedDrink: selectedDrink);

      await tester.tap(find.text('Water'));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(ListView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Soda').last);
      await tester.pumpAndSettle();

      expect(selectedDrink, 'Soda');
    });
  });
}

Future<void> _pumpWidget(WidgetTester tester, void Function(String?) onChanged,
    {String selectedDrink = 'Water'}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: DrinkSelectionButton(
          drink: selectedDrink,
          onChanged: onChanged,
        ),
      ),
    ),
  );
}
