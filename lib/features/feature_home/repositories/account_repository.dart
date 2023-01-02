
import '../models/user_model.dart';
import '../services/account_service.dart';

abstract class AccountRepository {
  Stream<UserModel> getUser();
}

class AccountRepositoryImpl implements AccountRepository {
  final AccountService accountService;

  AccountRepositoryImpl({
    required this.accountService,
  });

  @override
  Stream<UserModel> getUser() {
    return accountService.getUser();
  }
}