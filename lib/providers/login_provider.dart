// ignore_for_file: avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/pages/bottomNavBar/bottomNavBar.dart';
import 'package:win_kamu/utils/global_utils.dart';

class LoginProvider extends ChangeNotifier {
  final apirepository = APIRepository();

  test() {
    print(_kadi.text);
    print(_password.text);
  }

  final _kadi = TextEditingController();
  final _password = TextEditingController();
  bool _password_visible = true;

  TextEditingController get kadi => _kadi;
  TextEditingController get password => _password;
  bool get password_visible => _password_visible;

  set setPassword(String password) {
    _password.text = password;
    notifyListeners();
  }

  set setKadi(String kadi) {
    _kadi.text = kadi;
    notifyListeners();
  }

  set setVisible(bool password_visible) {
    _password_visible = password_visible;
    notifyListeners();
  }

  userLogin(BuildContext context) async {
    String apiresult = await apirepository.login(_kadi.text, _password.text);
    if (apiresult == 'success') {
      snackBar(context, 'Giriş İşlemi Başarılı', 'success');
      Navigator.push(context, MaterialPageRoute(builder: ((context) => const BottomNavBar())));
    } else {
      baglantiHatasi(context, apiresult.toString());
    }
  }
}
