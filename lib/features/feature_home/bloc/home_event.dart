import 'dart:ui';

abstract class HomeEvent {}

class HomeEventAddDrink extends HomeEvent {}

class FetchRemoteConfigEvent extends HomeEvent {}

class HandleDynamicLinkEvent extends HomeEvent {
  final void Function(int) callback;
  HandleDynamicLinkEvent(this.callback);
}