import 'package:equatable/equatable.dart';

enum HomeStatus {
  initial,
  loading,
  success,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final String progressIndicatorType;

  const HomeState({
    this.status = HomeStatus.initial,
    this.progressIndicatorType = 'circular',
  });

  HomeState copyWith({
    HomeStatus? status,
    String? progressIndicatorType,
  }) {
    return HomeState(
      status: status ?? this.status,
      progressIndicatorType: progressIndicatorType ?? this.progressIndicatorType,
    );
  }

  @override
  List<Object> get props => [status, progressIndicatorType];
}
