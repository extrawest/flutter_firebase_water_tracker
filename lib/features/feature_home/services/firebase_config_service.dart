import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _progressIndicatorTypeKey = 'progress_indicator_type';

const _defaults  = {
  _progressIndicatorTypeKey: 'circular',
};

abstract class FirebaseConfigService {
  String get progressIndicatorType;

  Future<void> initialize();
}

class FirebaseConfigServiceImpl implements FirebaseConfigService {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  String get progressIndicatorType => remoteConfig.getString(_progressIndicatorTypeKey);

  @override
  Future<void> initialize() async {
    remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 10),
      minimumFetchInterval: const Duration(minutes: 10),
    ));
    remoteConfig.setDefaults(_defaults);
    await remoteConfig.fetchAndActivate();
  }
}