// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:win_kamu/pages/WorkOrder/woTracingList.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/closeRequestsDetail.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/routeRequests.dart';
import 'package:win_kamu/pages/closedRequests/closedRequestsDetail.dart';
import 'package:win_kamu/pages/closedRequests/routeRequests.dart';
import 'package:win_kamu/pages/homePage.dart';

import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/pages/new_notif/new_notif.dart';
import 'package:win_kamu/pages/notiService.dart';
import 'package:win_kamu/pages/openRequests/openRequestsDetail.dart';
import 'package:win_kamu/pages/openRequests/routeRequests.dart';
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
import 'package:win_kamu/providers/select_environment_provider.dart';
import 'package:win_kamu/providers/work_order_view_provider.dart';
import 'package:win_kamu/providers/workorder_detail_provider.dart';

import 'package:win_kamu/providers/workorder_provider.dart';
import 'package:win_kamu/providers/search_view_provider.dart';
import 'package:rxdart/rxdart.dart';


void main() async {
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   return CustomLoadingScreen(
  //       backgroundColor: Colors.white, textColor: Colors.black);
  // };

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

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: ((data) async {
    onNotifications.add(data);
  }));

  void onClickedNotification(String? payload) {
    print('Foreground Payload : $payload');
  }

  onNotifications.stream.listen(onClickedNotification);

  runApp(Phoenix(
    child: MultiProvider(
      providers: providers,
      child: const MyApp(),
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
  ChangeNotifierProvider<WorkOrderViewProvider>(
      create: (_) => WorkOrderViewProvider()),
  ChangeNotifierProvider<IssueActionProvider>(
      create: (_) => IssueActionProvider()),
  ChangeNotifierProvider<SearchViewProvider>(
      create: (_) => SearchViewProvider()),
  ChangeNotifierProvider<EnvironmentProvider>(
      create: (_) => EnvironmentProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 1200,
        minWidth: 450,
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        MyHomePage.homePage: (context) => const MyHomePage(),
        MainPage.mainPage: (context) => const MainPage(),
        Login.login: (context) => const Login(),
        NewNotif.newNotif: (context) => const NewNotif(),
        OpenRequests.openRequest: (context) => const OpenRequests(),
        OpenRequestDetail.pageName: (context) => const OpenRequestDetail(),
        CloseRequestAwaitApproval.closeRequest: (context) =>
            const CloseRequestAwaitApproval(),
        CloseRequestDetail.closeRequestDetail: (context) =>
            const CloseRequestDetail(),
        PlannedRequest.plannedRequest: (context) => const PlannedRequest(),
        PlannedRequestDetail.plannedRequestDetail: (context) =>
            const PlannedRequestDetail(),
        ComplaintRequests.complaintRequests: (context) =>
            const ComplaintRequests(),
        ComplaintdRequestDetail.complaintdRequestDetail: (context) =>
            const ComplaintdRequestDetail(),
        ClosedRequests.closedRequests: (context) => const ClosedRequests(),
        ClosedRequestDetail.closedRequestDetail: (context) =>
            const ClosedRequestDetail(),
        WoTracingList.tracingList: (context) => const WoTracingList(),
      },
    );
  }
}
