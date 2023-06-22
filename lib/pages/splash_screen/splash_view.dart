// ignore_for_file: use_build_context_synchronously

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/bottomNavBar/bottomNavBar.dart';
import 'package:win_kamu/pages/login/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      //Uygulama açıldığı zaman, cihaz üzerinde local olarak kayıtlı olan tokenın kontrol edilmesi sağlanmaktadır.
      //Eğer ki herhangi bir token bulunmuyor ise kullanıcıyı login sayfasına yönlendirir.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final deviceInfoPlugin = DeviceInfoPlugin();

      final result = await deviceInfoPlugin.deviceInfo;
      var model = result.data['name'];
      var os = result.data['systemVersion'];

      try {
        prefs.setString('deviceId', result.data['identifierForVendor']);
        prefs.setString('deviceType', result.data['systemName']);
      } catch (e) {}

      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? fbtoken = await messaging.getToken();
      prefs.setString('fbtoken', fbtoken.toString());

      if (prefs.getString("prefsUserName") != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const BottomNavBar())));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Login())));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedWidget.tween(
      enabled: true,
      duration: const Duration(milliseconds: 3000),
      scaleDisabled: 0.5,
      scaleEnabled: 1,

      //your widget
      child: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset(
          'lib/assets/images/logo.png',
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
        ),
      ),
    );
  }
}
