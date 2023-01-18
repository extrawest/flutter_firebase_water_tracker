import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:water_tracker_app/features/feature_home/models/drink_model.dart';
import 'package:water_tracker_app/features/feature_home/widgets/drinks_list.dart';

void main() {
  testWidgets('should find widget in ListView', (widgetTester) async {
    final drinks = List.generate(
        100,
        (index) => const DrinkModel(
            name: 'Water', amount: 200, timestamp: '2021-09-01 12:00:00.000'));

    await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(body: Column(children: [DrinksList(drinks: drinks)]))));

    final listView = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('drink_98'));

    await widgetTester.scrollUntilVisible(
      itemFinder,
      500,
      scrollable: listView,
    );

    expect(itemFinder, findsOneWidget);
  });
}
