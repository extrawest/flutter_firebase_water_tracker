import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../repositories/account_repository.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository accountRepository;

  late StreamSubscription<UserModel> _userSubscription;

  AccountCubit(this.accountRepository) : super(const AccountState());

  Future<void> initScreen() async {
    try {
      final userStream = accountRepository.getUser();
      _userSubscription = userStream.listen((user) {
        emit(state.copyWith(user: user, status: AccountStatus.success));
      });
    }
    catch (e) {
      print(e);
      emit(state.copyWith(status: AccountStatus.failure));
    }
  }

  Future<void> signOut() async {
    accountRepository.signOut();
  }

  void dispose() {
    _userSubscription.cancel();
  }
}