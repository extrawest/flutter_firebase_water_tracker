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
      final userStream = await accountRepository.getUser();
      emit(state.copyWith(status: AccountStatus.success));
      _userSubscription = userStream.listen((user) {
        emit(state.copyWith(user: user));
      });
    }
    catch (e) {
      print(e);
      emit(state.copyWith(status: AccountStatus.failure));
    }
  }

  void dispose() {
    _userSubscription.cancel();
  }
}