import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/utils/global_utils.dart';

class LoginProvider extends ChangeNotifier {
    final apirepository = APIRepository();

   test (){
     print(_kadi.text);
     print(_password.text);
  }
  
    final _kadi = TextEditingController();
    final _password = TextEditingController();
    bool _password_visible = true;

      TextEditingController get kadi => _kadi;
      TextEditingController get password => _password;
      bool  get password_visible => _password_visible;

      set setPassword(String password) {
        _password.text = password;
        notifyListeners();
      }


      set setKadi(String kadi) {
        _kadi.text = kadi;
        notifyListeners();
      }  

      set setVisible(bool password_visible ){
        _password_visible = password_visible;
        notifyListeners();
      }  

       userLogin( BuildContext context) async {
         
          String apiresult = await apirepository.login2(_kadi.text,_password.text);
          if (apiresult == '201') {
          Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const MainPage()))); 
            
           } else {
                    baglantiHatasi(context, apiresult.toString());
          }
        }
        userLoginCheck(BuildContext context, kadi ,password) async{
          String apiresult = await apirepository.loginCheck(kadi,password);
        }
  
}