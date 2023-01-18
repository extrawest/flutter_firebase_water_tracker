import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/features/feature_home/widgets/bottom_app_bar.dart';

void main() {
  group('bottom app bar buttons', () {
    testWidgets(
      'should open modal dialog on AddDrinkButton Click',
      (widgetTester) async {
        await _pumpWidget(widgetTester, const BottomApplicationBar());
        await widgetTester.tap(find.byKey(const Key('add_drink_button')));
        await widgetTester.pumpAndSettle();
        expect(find.text('Add a drink'), findsOneWidget);
      },
    );

    testWidgets(
      'should open account info screen on account button click',
          (widgetTester) async {
        await _pumpWidget(widgetTester, const BottomApplicationBar());
        await widgetTester.tap(find.byKey(const Key('account_button')));
        await widgetTester.pumpAndSettle();
        expect(find.text('User info'), findsOneWidget);
      },
    );
  });
}

Future<void> _pumpWidget(WidgetTester tester ,Widget child) async {
  await tester.pumpWidget(MaterialApp(
    routes: {
      accountScreenRoute: (context) => const Scaffold(body: Text('User info'),),
    },
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      body: Column(
        children: [
          child,
        ],
      ),
    ),
  ));
}
