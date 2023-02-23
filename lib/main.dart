import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/pages/openRequests/openRequests.dart';
import 'package:win_kamu/pages/splash_screen/splash_view.dart';
import 'package:win_kamu/providers/login_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'buttonWidgets/customButtonWithGradient.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider()),
 
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        OpenRequests.openRequest: (context) => OpenRequests(),
        Login.login:(context) => Login(),
      },
    );
  }
}
