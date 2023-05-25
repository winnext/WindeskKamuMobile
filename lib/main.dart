import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:win_kamu/pages/WorkOrder/woList.dart';
import 'package:win_kamu/pages/WorkOrder/woTracingList.dart';
import 'package:win_kamu/pages/bottomNavBar/bottomNavBar.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/closeRequestsDetail.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/routeRequests.dart';
import 'package:win_kamu/pages/closedRequests/closedRequests.dart';
import 'package:win_kamu/pages/closedRequests/closedRequestsDetail.dart';
import 'package:win_kamu/pages/closedRequests/routeRequests.dart';
import 'package:win_kamu/pages/homePage.dart';

import 'package:win_kamu/pages/issue/routeIssue.dart';
import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/pages/new_notif/new_notif.dart';
import 'package:win_kamu/pages/new_notif/new_notif_base.dart';
import 'package:win_kamu/pages/notiService.dart';
import 'package:win_kamu/pages/openRequests/openRequestsDetail.dart';
import 'package:win_kamu/pages/openRequests/routeRequests.dart';
import 'package:win_kamu/pages/openRequests/openRequests.dart';
import 'package:win_kamu/pages/plannedRequests/plannedRequestsDetail.dart';
import 'package:win_kamu/pages/plannedRequests/routeRequests.dart';
import 'package:win_kamu/pages/complaintRequests/routeRequests.dart';
import 'package:win_kamu/pages/complaintRequests/complaintRequestsDetail.dart';
import 'package:win_kamu/pages/splash_screen/splash_view.dart';
//import 'package:win_kamu/providers/WoProviders/work_order_view_provider.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/issueaction_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/providers/login_provider.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/providers/new_notif_provider.dart';
import 'package:win_kamu/providers/work_order_view_provider.dart';
import 'package:win_kamu/providers/workorder_detail_provider.dart';

import 'package:win_kamu/providers/workorder_provider.dart';
import 'package:win_kamu/providers/search_view_provider.dart';
import 'package:win_kamu/utils/global_utils.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/widgets/buttonWidgets/homeButtons.dart';
import 'package:win_kamu/widgets/customLoadingScreenDialog.dart';
import 'widgets/buttonWidgets/customButtonWithGradient.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomLoadingScreen(
        backgroundColor: Colors.white, textColor: Colors.black);
  };

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final onNotifications = BehaviorSubject<String?>();

  FirebaseMessaging.onBackgroundMessage((message) =>
      NotificationApi.showNotification(
          title: "message.notification?.title",
          body: "message.notification?.body",
          payload: 'asd'));
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {}
    }
  });

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final IOSInitializationSettings initializationSettingsIOS =
      const IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final MacOSInitializationSettings initializationSettingsMacOS =
      const MacOSInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: ((data) async {
    onNotifications.add(data);
  }));

  void onClickedNotification(String? payload) {
    print('Foreground Payload : ' + payload.toString());
  }

  onNotifications.stream.listen(onClickedNotification);

  runApp(Phoenix(
    child: MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  ));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
  ChangeNotifierProvider<ListViewProvider>(create: (_) => ListViewProvider()),
  ChangeNotifierProvider<DetailViewProvider>(
      create: (_) => DetailViewProvider()),
  ChangeNotifierProvider<CrudViewProvider>(create: (_) => CrudViewProvider()),
  ChangeNotifierProvider<MainPageViewProvider>(
      create: (_) => MainPageViewProvider()),
  ChangeNotifierProvider<NewNotifProvider>(create: (_) => NewNotifProvider()),
  ChangeNotifierProvider<WorkOrderProvider>(create: (_) => WorkOrderProvider()),
  ChangeNotifierProvider<WorkOrderProvider>(create: (_) => WorkOrderProvider()),
  ChangeNotifierProvider<IssueActionProvider>(
      create: (_) => IssueActionProvider()),
  ChangeNotifierProvider<SearchViewProvider>(
      create: (_) => SearchViewProvider()),
  ChangeNotifierProvider<WoDetailViewProvider>(
      create: (_) => WoDetailViewProvider()),
      ChangeNotifierProvider<WorkOrderViewProvider>(create: (_) => WorkOrderViewProvider()),

  ChangeNotifierProvider<IssueActionProvider>(create: (_) => IssueActionProvider()),
  ChangeNotifierProvider<SearchViewProvider>(create: (_) => SearchViewProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);
    int numb = 0;
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 1200,
        minWidth: 450,
        // defaultScale: true,
        // breakpoints: [
        //   const ResponsiveBreakpoint.resize(450, name: MOBILE),
        //   const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //   const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        //   const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        //   const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        // ],
      ),
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
        Login.login: (context) => Login(),
        NewNotif.newNotif: (context) => NewNotif(),
        OpenRequests.openRequest: (context) => OpenRequests(),
        OpenRequestDetail.pageName: (context) => OpenRequestDetail(),
        CloseRequestAwaitApproval.closeRequest: (context) =>
            CloseRequestAwaitApproval(),
        CloseRequestDetail.closeRequestDetail: (context) =>
            CloseRequestDetail(),
        PlannedRequest.plannedRequest: (context) => PlannedRequest(),
        PlannedRequestDetail.plannedRequestDetail: (context) =>
            PlannedRequestDetail(),
        ComplaintRequests.complaintRequests: (context) => ComplaintRequests(),
        ComplaintdRequestDetail.complaintdRequestDetail: (context) =>
            ComplaintdRequestDetail(),
        ClosedRequests.closedRequests: (context) => ClosedRequests(),
        ClosedRequestDetail.closedRequestDetail: (context) =>
            ClosedRequestDetail(),
        WoTracingList.tracingList: (context) => WoTracingList(),
        
        
        
      },
    );
  }
}
