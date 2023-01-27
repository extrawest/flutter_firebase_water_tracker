
import 'package:water_tracker_app/features/feature_home/models/drink_model.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeInitUserEvent extends HomeEvent {}

class HomeInitDrinksEvent extends HomeEvent {}

class HomeEventAddDrink extends HomeEvent {
  final DrinkModel drink;
  const HomeEventAddDrink(this.drink);
}

class FetchRemoteConfigEvent extends HomeEvent {}

class HandleDynamicLinkEvent extends HomeEvent {
  final void Function(int) callback;
  HandleDynamicLinkEvent(this.callback);
}