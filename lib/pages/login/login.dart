import 'dart:async';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:win_kamu/providers/login_provider.dart';

import '../../utils/global_utils.dart';
import '../../utils/themes.dart';

class Login extends StatefulWidget {
  static String login = '/login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RoundedLoadingButtonController _btnController2 = RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 5), () {
      controller.success();
      _btnController2.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lProvider = Provider.of<LoginProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: _loginAppbar(context),
        backgroundColor: APPColors.Main.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Image.asset(
                    'lib/assets/images/loginPic.png',
                    height: MediaQuery.of(context).size.width / 1,
                    width: MediaQuery.of(context).size.width / 1,
                    fit: BoxFit.cover,
                    //color: Colors.amber,
                  )),
              const Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  'Merkezi Yardım Masası',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 28),
                )),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          controller: lProvider.kadi,
                          decoration: const InputDecoration(border: UnderlineInputBorder(), hintText: 'Kullanıcı Adı'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          controller: lProvider.password,
                          obscureText: lProvider.password_visible,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            hintText: 'Şifre',
                            suffixIcon: IconButton(
                              icon: lProvider.password_visible ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye_sharp),
                              onPressed: () {
                                setState(() {
                                  lProvider.setVisible = !lProvider.password_visible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: APPColors.Login.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          if (lProvider.password.text != '' && lProvider.kadi.text != '') {
                            lProvider.userLogin(context);
                          } else {
                            baglantiHatasi(context, 'Lütfen Boş Alan Bırakmayınız');
                          }
                        },
                        child: const Text('Giriş Yap'),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  AppBar _loginAppbar(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'lib/assets/images/windesk.jpg',
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.width / 1.5,
        fit: BoxFit.cover,
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: APPColors.Main.white,
    );
  }
}
