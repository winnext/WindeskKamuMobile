import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/utils/api_urls.dart';


class APIRepository {

   
    // Platform messages may fail, so we use a try/catch PlatformException.
    
  
  var deviceId =  PlatformDeviceId.getDeviceId;

  

    var dio = Dio();

  Future login(String kadi, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Device_id : ');
  print(deviceId.toString());
    String loginUrl  = base_url_v1+'wdaehtest!_'+deviceId.toString()+ '&action=loginCheck&username=' +
        kadi +
        '&password=' +
        password +
        '&platform=' +
        'ios' +
        '&version=' +
        '3'+
        '&mobileV2=true';
    var result = '';
    print(loginUrl);

          Future.delayed(const Duration(seconds: 2)).whenComplete(() {});

      try {
        BaseOptions options = BaseOptions(
   
    connectTimeout: Duration(milliseconds: 5000),
    receiveTimeout: Duration(milliseconds: 5000),
  );
  Dio dio = Dio(options);
  dio.options.receiveTimeout = Duration(milliseconds: 5000);

        final response = await dio.get(loginUrl,options: Options(
              responseType: ResponseType.json,
              
              
            )); 



        if (response.data['result'] == 'success') {  
            //print(response.data);
            prefs.setString('prefsUserName', kadi);

            print('Giriş İşlemi Başarılı');     
        } else {
            print(response.data['result']);

        }
        return response.data['result'];      

      } on DioError catch (e) {
        

            return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

     
      
    }       

    
  }

}