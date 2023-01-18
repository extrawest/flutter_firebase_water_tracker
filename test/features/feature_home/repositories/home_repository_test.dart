import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:water_tracker_app/features/feature_home/models/drink_model.dart';
import 'package:water_tracker_app/features/feature_home/models/user_model.dart';
import 'package:water_tracker_app/features/feature_home/repositories/home_repository.dart';

import 'home_repository_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
  });

  test('should retrieve progress indicator type from remote config', () async {
    when(mockHomeRepository.getProgressIndicatorType())
        .thenAnswer((_) async => 'circular');

    final progressIndicatorType =
        await mockHomeRepository.getProgressIndicatorType();

    expect(progressIndicatorType, 'circular');
  });

  group('Firestore', () {
    test('should retrieve user model from firestore', () async {
      when(mockHomeRepository.userStream()).thenAnswer(
        (_) => Stream.periodic(
          const Duration(seconds: 1),
          (_) {
            return const UserModel(
                name: 'name',
                email: 'email',
                photoUrl: 'photoUrl',
                dailyGoal: 4000);
          },
        ),
      );

      final userStream = mockHomeRepository.userStream();

      expect(userStream, isA<Stream<UserModel>>());
    });

    test('should retrieve drink model from firestore', () async {
      when(mockHomeRepository.drinksStream()).thenAnswer(
        (_) => Stream.periodic(
          const Duration(seconds: 1),
          (_) {
            return [
              const DrinkModel(
                name: 'name',
                amount: 100,
                timestamp: 'timestamp',
              )
            ];
          },
        ),
      );

      final drinksStream = mockHomeRepository.drinksStream();

      expect(drinksStream, isA<Stream<List<DrinkModel>>>());
    });

    test('should add drink to firestore', () async {
      when(mockHomeRepository.addDrink(
        drinkAmount: 100,
        drinkName: 'name',
      )).thenAnswer((_) async => true);

      final isAdded = await mockHomeRepository.addDrink(
        drinkAmount: 100,
        drinkName: 'name',
      );

      expect(isAdded, true);
    });
  });
}
