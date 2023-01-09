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
    catch (e, stackTrace) {
      emit(state.copyWith(status: AccountStatus.failure));
      accountRepository.recordError(e.toString(), stackTrace, reason: 'Account Error');
    }
  }

  Future<int> getOverallWaterIntake() async {
    return accountRepository.getOverallWaterIntake();
  }

  Future<Uri> createDynamicLink({required String path}) async {
    return await accountRepository.createDynamicLink(path: path);
  }

  Future<void> uploadPhoto() async {
    try {
      await accountRepository.uploadPhoto();
    }
    catch (e, stackTrace) {
      accountRepository.recordError(e.toString(), stackTrace, reason: 'Account Error');
    }
  }

  Future<void> signOut() async {
    accountRepository.signOut();
  }

  Future<void> dispose() async {
    await _userSubscription.cancel();
  }
}