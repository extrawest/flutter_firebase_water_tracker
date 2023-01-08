import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        bool isOpenedFromNotification = false;
        FirebaseMessaging.instance.getInitialMessage().then((message) {
          if(message != null){
            Navigator.of(context).pushReplacementNamed(message.data["route"]);
          }
          isOpenedFromNotification = true;
        });
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          Navigator.of(context).pushReplacementNamed(message.data["route"]);
          isOpenedFromNotification = true;
        });
        if(!isOpenedFromNotification) {
          FirebaseAuth.instance.currentUser == null
              ? Navigator.of(context).pushReplacementNamed(signInScreenRoute)
              : Navigator.of(context).pushReplacementNamed(homeScreenRoute);
        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Splash Screen', style: TextStyle(fontSize: 24,color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
