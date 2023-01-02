import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_event.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_state.dart';
import 'package:water_tracker_app/features/feature_home/repositories/home_repository.dart';

import '../models/drink_model.dart';

final _drinks = {
  0: 'Water',
  1: 'Tea',
  2: 'Coffee',
  3: 'Juice',
  4: 'Milk',
  5: 'Beer',
  6: 'Wine',
  7: 'Soda',
};

int _getRandomNumber({required int upTo}) {
  final random = Random();
  final randomInt = random.nextInt(upTo);
  return randomInt - randomInt % 10;
}

String _getRandomDrink() {
  final random = _drinks.keys.toList()..shuffle();
  return _drinks[random.first]!;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final HomeRepository _homeRepository;
  late Stream<Map<String, dynamic>> userStream = _homeRepository.userStream();
  late Stream<List<Drink>> drinksStream = _homeRepository.drinksStream();
  late Stream<List<Drink>> drinksStreamSecond =
      _homeRepository.drinksStream();

  HomeBloc(this._homeRepository) : super(const HomeState()) {
    on<HomeEventAddDrink>(_addDrink);
  }

  Future<void> _addDrink(
    HomeEventAddDrink event,
    Emitter<HomeState> emit,
  ) async {
    await _homeRepository.addDrink(
      drinkName: _getRandomDrink(),
      drinkAmount: _getRandomNumber(upTo: 400),
    );
  }

  int calculateOverallVolume(List<Drink> drinks) {
    return drinks.fold(
        0, (previousValue, element) => previousValue + element.amount);
  }

  double calculateProgress(int current, int goal) {
    final adjustedCurrent = current > goal ? goal : current;
    return adjustedCurrent / goal;
  }
}
