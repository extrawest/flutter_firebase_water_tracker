import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_bloc.dart';
import 'package:water_tracker_app/features/feature_home/models/drink_model.dart';
import 'package:water_tracker_app/features/feature_home/repositories/home_repository.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([HomeRepositoryImpl])
void main() {
  late HomeBloc homeBloc;
  late MockHomeRepositoryImpl mockHomeRepositoryImpl;

  setUp(() {
    mockHomeRepositoryImpl = MockHomeRepositoryImpl();
    homeBloc = HomeBloc(mockHomeRepositoryImpl);
  });

  test('should return random amount of drink volume', () {
    final example1 = getRandomNumber(upTo: 500);
    final example2 = getRandomNumber(upTo: 500);

    expect(example1, isNot(example2));
  });

  test('should return random drink name', () {
    final example1 = getRandomDrink();
    final example2 = getRandomDrink();

    expect(example1, isNot(example2));
  });

  test('should calculate daily progress base on current intake', () {
    const currentIntake = 1000;
    const goal = 2000;
    const expectedProgress = currentIntake > goal ? goal : currentIntake / goal;

    expect(homeBloc.calculateProgress(currentIntake, goal), expectedProgress);
  });

  test('should calculate overall volume of consumed drinks over a day', () {
    final drinks = [
      DrinkModel(name: 'name', amount: 50, timestamp: 'timestamp'),
      DrinkModel(name: 'name', amount: 50, timestamp: 'timestamp'),
      DrinkModel(name: 'name', amount: 50, timestamp: 'timestamp'),
      DrinkModel(name: 'name', amount: 50, timestamp: 'timestamp'),
    ];
    final expected = drinks.fold<int>(0, (previousValue, element) => previousValue + element.amount);
    expect(homeBloc.calculateOverallVolume(drinks), expected);
  });
}
