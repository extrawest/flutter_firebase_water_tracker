import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

abstract class DynamicLinksService {
  Future<Uri> createDynamicLink({required String path});
  Future<void> handleDynamicLink(void Function(int) callback);
}

class DynamicLinksServiceImpl implements DynamicLinksService {
  final FirebaseDynamicLinks _dynamicLinks;

  DynamicLinksServiceImpl({FirebaseDynamicLinks? dynamicLinks})
      : _dynamicLinks = dynamicLinks ?? FirebaseDynamicLinks.instance;

  @override
  Future<Uri> createDynamicLink({required String path}) async {
    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://mowatertrackerapp.page.link',
      link: Uri.parse('https://mowatertrackerapp.page.link/$path'),
      androidParameters: const AndroidParameters(
        packageName: 'com.extrawest.water_tracker_app',
        minimumVersion: 1,
      ),
    );
    return await _dynamicLinks.buildLink(parameters);
  }

  @override
  Future<void> handleDynamicLink(void Function(int) callback) async {
    final PendingDynamicLinkData? deepLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (deepLink != null) {
      callback(int.parse(deepLink.link.queryParameters['intake']?? '0'));
    }
    FirebaseDynamicLinks.instance.onLink.listen((deepLink) {
      callback(int.parse(deepLink.link.queryParameters['intake']?? '0'));
    }, onError: (e) {
      callback(0);
    });
  }
}