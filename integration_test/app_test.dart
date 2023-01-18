import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:water_tracker_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('should go through all app', (tester) async {
      await app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const ValueKey('signUpButton')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const ValueKey('nameField')), 'Test Test');
      await tester.enterText(find.byKey(const ValueKey('emailField')), 'test@mail.com');
      await tester.enterText(find.byKey(const ValueKey('passwordField')), 'test123');
      await tester.enterText(find.byKey(const ValueKey('confirmPasswordField')), 'test123');

      await tester.tap(find.byKey(const ValueKey('registerButton')));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const ValueKey('add_drink_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('drink_selection_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('Coffee')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const ValueKey('drink_amount_input')), '200');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('drink_dialog_add_button')));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.text('Todays drinks'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Overall volume'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('account_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('logout_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.enterText(find.byKey(const ValueKey('signInEmailInput')), 'test@mail.com');
      await tester.enterText(find.byKey(const ValueKey('signInPasswordInput')), 'test123');
      await tester.tap(find.byKey(const ValueKey('signInButton')));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byKey(const ValueKey('water_tracker_view')), findsOneWidget);
    });
  });
}
