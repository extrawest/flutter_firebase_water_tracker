
import '../models/user_model.dart';
import '../services/account_service.dart';

abstract class AccountRepository {
  Stream<UserModel> getUser();
  Future<void> uploadPhoto();
  Future<void> signOut();
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

  @override
  Future<void> uploadPhoto() async {
    await accountService.uploadPhoto();
  }

  @override
  Future<void> signOut() async {
    await accountService.signOut();
  }
}