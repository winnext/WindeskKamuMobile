import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/pages/new_notif/new_notif.dart';
import 'package:win_kamu/pages/openRequests/openRequestsDetail.dart';
import 'package:win_kamu/pages/openRequests/routeRequests.dart';
import 'package:win_kamu/pages/openRequests/openRequests.dart';
import 'package:win_kamu/pages/splash_screen/splash_view.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/providers/login_provider.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'widgets/buttonWidgets/customButtonWithGradient.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
  ChangeNotifierProvider<ListViewProvider>(create: (_) => ListViewProvider()),
  ChangeNotifierProvider<DetailViewProvider>(
      create: (_) => DetailViewProvider()),
  ChangeNotifierProvider<CrudViewProvider>(create: (_) => CrudViewProvider()),
  ChangeNotifierProvider<MainPageViewProvider>(
      create: (_) => MainPageViewProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);
    int numb = 0;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        MyHomePage.homePage: (context) => MyHomePage(),
        MainPage.mainPage: (context) => MainPage(),
        OpenRequests.openRequest: (context) => OpenRequests(),
        Login.login: (context) => Login(),
        NewNotif.newNotif: (context) => NewNotif(),
        OpenRequestDetail.pageName: (context) => OpenRequestDetail(),
      },
    );
  }
}
