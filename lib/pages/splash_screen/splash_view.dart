import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/bottomNavBar/bottomNavBar.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/pages/mainPage.dart';

import '../../providers/login_provider.dart';
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
      final deviceInfoPlugin = DeviceInfoPlugin();

      final result = await deviceInfoPlugin.deviceInfo;

      try {
        prefs.setString('deviceId', result.data['identifierForVendor']);
        prefs.setString('deviceType', result.data['systemName']);
      } catch (e) {}




      if (prefs.getString("prefsUserName") != null) {
         String loginUrl = 'http://localhost:3012/user/login';
                        try {
                Dio dio = Dio();
                final response = await dio.post(loginUrl,
                  data: {'username': prefs.getString('prefsUserName'), 'password': prefs.getString('prefsPassword')},
                    options: Options(
                      responseType: ResponseType.json,
                    ));
                  print('sonuc');
                print(response.statusCode);
                String token = response.data['access_token'];
                print('token : '+token);
                if (response.statusCode== 201) {
                  //print(response.data);
                // prefs.setString('prefsUserName', prefs.getString('prefsUserName'));
                  //prefs.setString('prefsPassword',password);

                  print('Giriş İşlemi Başarılı');
                } else {
                  print(response.data['result']);
                }
                if(token == prefs.getString('prefsToken')){
                                    prefs.setString('prefsToken',token);

                  print('Tokenlar eşleşti');
                                Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => const BottomNavBar())));

                            }else{
                                Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => const Login())));
                            }
              } on DioError catch (e) {
                print('Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz');
              }
                            
      
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const Login())));
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
          'lib/assets/images/logo.png',
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
        ),
      ),
    );
  }
}
