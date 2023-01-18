import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_event.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_state.dart';
import 'package:water_tracker_app/features/feature_home/models/user_model.dart';
import 'package:water_tracker_app/features/feature_home/repositories/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final HomeRepository _homeRepository;
  late Stream<UserModel> userStream = _homeRepository.userStream();

  HomeBloc(this._homeRepository) : super(const HomeState()) {
    on<HomeInitUserEvent>(_homeInitUserEvent);
    on<HomeInitDrinksEvent>(_homeInitDrinksEvent);
    on<HomeEventAddDrink>(_addDrink);
    on<FetchRemoteConfigEvent>(_fetchRemoteConfig);
    on<HandleDynamicLinkEvent>(_handleDynamicLink);
  }

  double get overallVolume {
    final drinks = state.drinks;
    if (drinks.isNotEmpty) {
      return drinks.fold(0, (previousValue, element) => previousValue + element.amount);
    }
    else {
      return 0;
    }
  }

  double get overallVolumePercentage {
    final overallVolume = this.overallVolume;
    final goal = state.user?.dailyGoal ?? 0;
    return (overallVolume > goal ? goal : overallVolume) / goal;
  }

  Future<void> _homeInitUserEvent(HomeInitUserEvent event, Emitter<HomeState> emit) async {
    await emit.forEach(
      _homeRepository.userStream(),
      onData: (user) => state.copyWith(user: () => user, status: HomeStatus.success),
    );
  }

  Future<void> _homeInitDrinksEvent(HomeInitDrinksEvent event, Emitter<HomeState> emit) async {
    await _homeRepository.initDay();
    await emit.forEach(
      _homeRepository.drinksStream(),
      onData: (drinks) => state.copyWith(drinks: drinks, status: HomeStatus.success),
    );
  }

  Future<void> _addDrink(
    HomeEventAddDrink event,
    Emitter<HomeState> emit,
  ) async {
    await _homeRepository.addDrink(
      drinkName: event.drink.name,
      drinkAmount: event.drink.amount,
    );
  }

  Future<void> _fetchRemoteConfig(
    FetchRemoteConfigEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final progressIndicatorType =
          await _homeRepository.getProgressIndicatorType();
      emit(state.copyWith(
          progressIndicatorType: progressIndicatorType,
          status: HomeStatus.success));
    } catch (e, stackTrace) {
      // emit(state.copyWith(status: HomeStatus.failure));
      await _homeRepository.recordError(e.toString(), stackTrace, reason: e);
    }
  }

  Future<void> _handleDynamicLink(
    HandleDynamicLinkEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _homeRepository.handleDynamicLink(event.callback);
  }

  double calculateProgress(int current, int goal) {
    final adjustedCurrent = current > goal ? goal : current;
    return adjustedCurrent / goal;
  }
}
