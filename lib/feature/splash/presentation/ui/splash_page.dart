import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'dart:io' show Platform, exit;

import '../../../../common/utils/custom_dialog.dart';
import '../../../../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _jailBroken = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'SplashPage',
      screenClassOverride: 'SplashPage',
    );
    _checkJailBreak();
  }

  _checkJailBreak() async {
    bool jailBroken = false;
    try {
      jailBroken = true; //await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      jailBroken = true;
    }
    setState(() {
      _jailBroken = jailBroken;
    });
  }

  var dialog = CustomAlertDialog(
      title: 'Alert',
      message:
          'This device is ${Platform.isAndroid ? 'rooted' : 'jailbroken'}, We recommend not to use app on this device. \nDo you still want to continue?',
      onPostivePressed: () {
        Navigator.pop(navigatorKey.currentContext!);
        Navigator.of(navigatorKey.currentContext!)
            .pushReplacementNamed('login');
      },
      onNegativePressed: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
      positiveBtnText: 'Yes',
      negativeBtnText: 'No');

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => _jailBroken
          ? showDialog(
              context: context, builder: (BuildContext context) => dialog)
          : Navigator.of(context).pushReplacementNamed('login'),
    );
    return Scaffold(
      body: Center(
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}
