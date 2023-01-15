import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_bloc.dart';
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
}
