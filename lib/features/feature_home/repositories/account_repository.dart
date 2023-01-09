
import 'package:water_tracker_app/features/feature_home/services/dynamic_links_service.dart';

import '../models/user_model.dart';
import '../services/FirebaseCrashlyticsService.dart';
import '../services/account_service.dart';

abstract class AccountRepository {
  Stream<UserModel> getUser();
  Future<int> getOverallWaterIntake();
  Future<void> uploadPhoto();
  Future<void> signOut();
  Future<Uri> createDynamicLink({required String path});
  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason});
}

class AccountRepositoryImpl implements AccountRepository {
  final AccountService accountService;
  final DynamicLinksService dynamicLinkService;
  final FirebaseCrashlyticsService firebaseCrashlyticsService;

  AccountRepositoryImpl({
    required this.accountService,
    required this.dynamicLinkService,
    required this.firebaseCrashlyticsService,
  });

  @override
  Stream<UserModel> getUser() {
    return accountService.getUser();
  }

  @override
  Future<int> getOverallWaterIntake() async {
    return accountService.getOverallWaterIntake();
  }

  @override
  Future<void> uploadPhoto() async {
    await accountService.uploadPhoto();
  }

  @override
  Future<void> signOut() async {
    await accountService.signOut();
  }

  @override
  Future<Uri> createDynamicLink({required String path}) async {
    return await dynamicLinkService.createDynamicLink(path: path);
  }

  @override
  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason}) {
    return firebaseCrashlyticsService.recordError(message, stackTrace, reason: reason);
  }
}