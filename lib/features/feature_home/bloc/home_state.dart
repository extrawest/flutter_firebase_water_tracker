import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/drink_model.dart';
import '../models/user_model.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure
}

class HomeState extends Equatable {
  final HomeStatus status;
  final UserModel? user;
  final List<DrinkModel> drinks;
  final String progressIndicatorType;

  const HomeState({
    this.status = HomeStatus.initial,
    this.progressIndicatorType = 'circular',
    this.user,
    this.drinks = const [],
  });

  HomeState copyWith({
    HomeStatus? status,
    String? progressIndicatorType,
    ValueGetter<UserModel?>? user,
    List<DrinkModel>? drinks,
  }) {
    return HomeState(
      status: status ?? this.status,
      progressIndicatorType: progressIndicatorType ?? this.progressIndicatorType,
      user: user != null ? user() : this.user,
      drinks: drinks ?? this.drinks,
    );
  }

  @override
  List<Object?> get props => [status, progressIndicatorType, user, drinks];
}
