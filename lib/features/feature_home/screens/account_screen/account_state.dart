import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

enum AccountStatus { initial, loading, success, failure }

class AccountState extends Equatable {
  final UserModel? user;
final AccountStatus status;

  const AccountState({
    this.user,
    this.status = AccountStatus.initial,
  });

  AccountState copyWith({
    UserModel? user,
    AccountStatus? status,
  }) {
    return AccountState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [user, status];
}
