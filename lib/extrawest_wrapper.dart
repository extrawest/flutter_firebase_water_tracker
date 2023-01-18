import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water_tracker_app/common/ui/theme/theme.dart';

import 'common/routes.dart';

class ExtrawestWrapper extends StatelessWidget {
  const ExtrawestWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Tracker',
      theme: applicationTheme,
      home: Scaffold(
        body: Column(
          children: [
            const Expanded(
              child: Navigator(
                initialRoute: splashScreenRoute,
                onGenerateRoute: onGenerateRoute,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black87,
                textStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () async {
                await launchUrl(Uri.parse('https://www.extrawest.com/'));
              },
              child: const Text('Made by Extrawest'),
            ),
            if(Platform.isIOS) const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
