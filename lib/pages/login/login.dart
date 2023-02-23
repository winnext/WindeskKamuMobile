import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:win_kamu/providers/login_provider.dart';


import '../../buttonWidgets/homeButtons.dart';
import '../../utils/themes.dart';

class Login extends StatefulWidget {
    static String login = '/login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 


  @override
  Widget build(BuildContext context) {

    final lProvider = Provider.of<LoginProvider>(context);
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'lib/assets/windesk.jpg',
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.width / 1.5,
            fit: BoxFit.cover,
          ),
          
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: APPColors.Main.white,
       
        ),
        backgroundColor: APPColors.Main.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Image.asset(
                    'lib/assets/loginPic.png',
                    height: MediaQuery.of(context).size.width / 1,
                    width: MediaQuery.of(context).size.width / 1,
                    fit: BoxFit.cover,
                    //color: Colors.amber,
                  )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(child: Text('Merkezi Yardım Masası' ,style: TextStyle(fontFamily: 'Roboto', fontSize: 28, ),))),
        
                    ),
              Expanded(
                      flex:3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          
                          
                          children: [
                             Padding(padding: EdgeInsets.symmetric(horizontal: 30.0),
                             child: TextField(
                                controller: lProvider.kadi,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Kullanıcı Adı',
                                ),
                              ),
                             ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: TextField(
                                controller: lProvider.password,
                                obscureText: lProvider.password_visible,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Şifre',
                                
                                  
                                  suffixIcon: IconButton(
                                    icon: lProvider.password_visible ?  Icon(Icons.remove_red_eye_outlined) : Icon(Icons.remove_red_eye_sharp) ,
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
                        ),
                      ) 
                      ),Expanded(
                        flex: 2,
                        child: 
                           Center(
                             child: Container(
                                  width: 200 ,
                                  height: 50,
                                  
                                  child: 
                                  ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: APPColors.Login.blue,
                                              shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20), // <-- Radius
                                            ),
                                          
                                        ),
                                        onPressed: () {
                                          
                                            lProvider.userLogin(context);
                                        },
                                        child: const Text('Giriş Yap'),
                                      ),
                                  ),
                           )  
                        )
            ],
          ),
        ),
      ),
    );
  }
}