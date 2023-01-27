import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:water_tracker_app/features/feature_login/widgets/form_input.dart';

void main() {
  testWidgets('should enter text in text field', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: FormInput(
          label: 'label',
          hint: 'hint',
          icon: Icons.email,
        ),
      ),
    ));

    final textField = find.byType(TextField);

    await widgetTester.enterText(textField, 'test');
    await widgetTester.pump();

    expect(find.text('test'), findsOneWidget);
  });
}
