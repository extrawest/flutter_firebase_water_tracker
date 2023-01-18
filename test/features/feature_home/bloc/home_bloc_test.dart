import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_bloc.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_event.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_state.dart';
import 'package:water_tracker_app/features/feature_home/models/drink_model.dart';
import 'package:water_tracker_app/features/feature_home/models/user_model.dart';
import 'package:water_tracker_app/features/feature_home/repositories/home_repository.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([HomeRepositoryImpl])
void main() {
  group('HomeBlocTest', () {
    blocTest(
      'should emit [HomeState(progressIndicatorType: \'linear\', status: HomeStatus.success),] when FetchRemoteConfigEvent is called',
      build: () {
        final mockHomeRepository = MockHomeRepositoryImpl();
        when(mockHomeRepository.getProgressIndicatorType())
            .thenAnswer((_) async => 'linear');
        return HomeBloc(mockHomeRepository);
      },
      act: (bloc) => bloc.add(FetchRemoteConfigEvent()),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        const HomeState(
            progressIndicatorType: 'linear', status: HomeStatus.success),
      ],
    );
    blocTest(
      'should emit [HomeState(progressIndicatorType: \'circular\', status: HomeStatus.failure),] when FetchRemoteConfigEvent is failed',
      build: () {
        final mockHomeRepository = MockHomeRepositoryImpl();
        when(mockHomeRepository.getProgressIndicatorType())
            .thenThrow(Exception('Failed to fetch remote config'));
        return HomeBloc(mockHomeRepository);
      },
      act: (bloc) => bloc.add(FetchRemoteConfigEvent()),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        const HomeState(
            progressIndicatorType: 'circular', status: HomeStatus.failure),
      ],
    );
    blocTest(
      'should emit [user: UserModel(...), status: HomeStatus.success] when HomeInitUserEvent is called',
      build: () {
        final mockHomeRepository = MockHomeRepositoryImpl();
        when(mockHomeRepository.userStream())
            .thenAnswer((_) => Stream.value(const UserModel(
                  name: 'Test',
                  dailyGoal: 2000,
                  email: 'email',
                  photoUrl: 'photoUrl',
                )));
        return HomeBloc(mockHomeRepository);
      },
      act: (bloc) => bloc.add(HomeInitUserEvent()),
      expect: () => [
        const HomeState(
          user: UserModel(
            name: 'Test',
            dailyGoal: 2000,
            email: 'email',
            photoUrl: 'photoUrl',
          ),
          status: HomeStatus.success,
        ),
      ],
    );
    blocTest(
      'should emit [drink: DrinkModel(...), status: HomeStatus.success] when HomeInitDrinksEvent is called',
      build: () {
        final mockHomeRepository = MockHomeRepositoryImpl();
        when(mockHomeRepository.drinksStream()).thenAnswer((_) => Stream.value([
              const DrinkModel(
                name: 'name',
                amount: 100,
                timestamp: 'timestamp',
              ),
            ]));
        return HomeBloc(mockHomeRepository);
      },
      act: (bloc) => bloc.add(HomeInitDrinksEvent()),
      expect: () => [
        const HomeState(
          drinks: [
            DrinkModel(
              name: 'name',
              amount: 100,
              timestamp: 'timestamp',
            )
          ],
          status: HomeStatus.success,
        ),
      ],
    );
  });
}
