import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/login/login.dart';

import '../../utils/themes.dart';

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
       if( prefs.getString("prefsUserName") != null ){
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => const MyHomePage() )));
       }else{

          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => const Login() )));
       }

    
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedWidget.tween(
      enabled: true,
      duration: Duration(milliseconds: 3000),
      scaleDisabled: 0.5,
      scaleEnabled: 1,

      //your widget
      child: Container(
        height: 200,
        width: 200,
        child: Image.asset(
            'lib/assets/logo.png',
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.width / 1.5,
            
          ),
      ),
    );
  }
}
