import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:water_tracker_app/features/feature_home/widgets/drink_amount_input.dart';

void main() {
  testWidgets('should input drink amount in textfieild', (widgetTester) async {
    // arrange
    await widgetTester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DrinkAmountInput(
          onChanged: (string) {},
        ),
      ),
    ));
    const drinkAmount = '200';
    final drinkInput = find.byKey(const Key('drink_amount_input'));

    await widgetTester.enterText(drinkInput, drinkAmount);

    expect(find.text(drinkAmount), findsOneWidget);
  });
}
