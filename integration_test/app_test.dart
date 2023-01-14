import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:water_tracker_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('should redirect user to signup screen', (tester) async {
      await app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const ValueKey('signUpButton')));

      await tester.pumpAndSettle();

      expect(find.text('Sign Up'), findsOneWidget);
    });
  });
}
