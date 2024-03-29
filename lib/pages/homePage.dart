// ignore_for_file: prefer_interpolation_to_compose_strings, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:badges/badges.dart' as badges;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:win_kamu/pages/WorkOrder/woTracingList.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/routeRequests.dart';
import 'package:win_kamu/pages/complaintRequests/routeRequests.dart';
import 'package:win_kamu/pages/new_notif/new_notif.dart';
import 'package:win_kamu/pages/notiService.dart';
import 'package:win_kamu/utils/global_utils.dart';

import '../api/api_repository.dart';
import '../providers/main_page_view_provider.dart';
import '../utils/themes.dart';
import '../widgets/buttonWidgets/homeButtons.dart';
import '../widgets/modalWidgets/announcementModal.dart';
import 'issue/routeIssue.dart';

class MyHomePage extends StatefulWidget {
  static String homePage = '/homePage';

  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  showAlertDialog(BuildContext context, title, body, module, code) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("İptal"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Talebe Git"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    final onNotifications = BehaviorSubject<String?>();

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

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

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: ((data) async {
      onNotifications.add(data);
    }));

    void onClickedNotification(String? payload) {
      String data = payload.toString();
      final splittedData = data.split('/-*-/');
      String title = splittedData[0];
      String body = splittedData[1];
      String module = splittedData[2];
      String code = splittedData[3];

      showAlertDialog(context, title, body, module, code);
    }

    onNotifications.stream.listen(onClickedNotification);

// Lisitnening to the background messages
    Future<void> _firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      await Firebase.initializeApp();
    }

// Lisitnening to the background messages
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listneing to the foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var payload =
          '${(message.notification?.title).toString() + '/-*-/' + (message.notification?.body).toString() + '/-*-/' + message.data['module']}/-*-/' +
              message.data['code'];
      NotificationApi.showNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          payload: payload);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showAlertDialog(
          context,
          message.notification?.title,
          message.notification?.body,
          message.data['module'],
          message.data['code']);
      //FlutterLocalNotificationsPlugin().show(message.notification.messageId, message.notification?.title, message.notification?.body,);
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      final mainPageViewProvider =
          Provider.of<MainPageViewProvider>(context, listen: false);
      mainPageViewProvider.announcementView.clear();
      mainPageViewProvider.getAnnouncements(mainPageViewProvider.kadi);

      // Future.delayed(const Duration(milliseconds: 1000), () {
      //   mainPageViewProvider.resultDeviceId == 'success'
      //       ? true
      //       : {
      //           snackBar(context,
      //               'Token süreniz dolmuştur. Yeniden giriş yapınız.', 'error'),
      //           apirepository.cikis(mainPageViewProvider.kadi),
      //           Future.delayed(const Duration(seconds: 4)).whenComplete(() {
      //             Phoenix.rebirth(context);
      //           })
      //         };
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apirepository = APIRepository();

    final mainViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/images/windesk.jpg',
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.width / 1.2,
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              size: 35,
              color: APPColors.Main.black,
            ),
            tooltip: 'Exit',
            onPressed: () async {
              var cikis_result =
                  await apirepository.cikis(mainViewProvider.kadi);
              try {
                if (cikis_result) {
                  snackBar(context, 'Çıkış İşlemi Başarılı', 'success');

                  Future.delayed(const Duration(seconds: 1)).whenComplete(() {
                    Phoenix.rebirth(context);
                  });
                } else {}
              } catch (e) {
                snackBar(context, 'Çıkış İşlemi Başarısız', 'error');
              }
=======
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'lib/assets/images/windesk.jpg',
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.width / 1.2,
            fit: BoxFit.cover,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                size: 35,
                color: APPColors.Main.black,
              ),
              tooltip: 'Exit',
              onPressed: () async {
                var cikisResult =
                    await apirepository.cikis(mainViewProvider.kadi);
                try {
                  if (cikisResult) {
                    snackBar(context, 'Çıkış İşlemi Başarılı', 'success');

                    Future.delayed(const Duration(seconds: 1)).whenComplete(() {
                      Phoenix.rebirth(context);
                    });
                  } else {}
                } catch (e) {
                  snackBar(context, 'Çıkış İşlemi Başarısız', 'error');
                }
              },
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: APPColors.Main.white,
          leading: Builder(
            builder: (BuildContext context) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                badgeContent: Text(
                  mainViewProvider.toplamKayitSayisi.toString(),
                  style: TextStyle(color: APPColors.Main.white),
                ),
                onTap: () {},
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 35,
                    color: APPColors.Main.black,
                  ),
                  onPressed: () {
                    // ignore: unrelated_type_equality_checks
                    mainViewProvider.toplamKayitSayisi != 0
                        ? showModalBottomSheet<void>(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            elevation: 10,
                            context: context,
                            builder: (context) => const AnnouncementList())
                        : null;
                  },
                ),
              );
>>>>>>> 7c825ae1c3be870afca98609aae6bca89bc40b8e
            },
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: APPColors.Main.white,
        leading: Builder(
          builder: (BuildContext context) {
            return badges.Badge(
              position: badges.BadgePosition.topEnd(top: 10, end: 10),
              badgeContent: Text(
                mainViewProvider.toplamKayitSayisi.toString(),
                style: TextStyle(color: APPColors.Main.white),
              ),
              onTap: () {},
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 35,
                  color: APPColors.Main.black,
                ),
                onPressed: () {
                  // ignore: unrelated_type_equality_checks
                  mainViewProvider.toplamKayitSayisi != 0
                      ? showModalBottomSheet<void>(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          elevation: 10,
                          context: context,
                          builder: (context) => AnnouncementList())
                      : null;
                },
              ),
            );
          },
        ),
      ),
      backgroundColor: APPColors.Main.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Expanded(
            //     flex: 3,
            //     child: Image.asset(
            //       'lib/assets/images/home.jpg',
            //       height: MediaQuery.of(context).size.width / 1,
            //       width: MediaQuery.of(context).size.width / 1,
            //       fit: BoxFit.cover,
            //       //color: Colors.amber,
            //     )),
            Expanded(child: Divider()),
            Expanded(
                child: Column(
              children: [
                Text(
                  'Ankara Etlik Şehir Hastanesi',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
                Text(
                  'Yardım Masası Uygulaması',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            )),

            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeButton(
                              text: LocaleKeys.vakaList.tr(),
                              iconName: Icons.calendar_month,
                              navigator: Issue()),
                        ),
                        Expanded(
                          child: HomeButton(
                              text: LocaleKeys.vakaArama.tr(),
                              iconName: Icons.attachment,
                              navigator: NewNotif()),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeButton(
                              text: LocaleKeys.isEmriList,
                              iconName: Icons.content_paste_search,
                              navigator: WoTracingList()),
                        ),
                        Expanded(
                          child: HomeButton(
                              text: LocaleKeys.isEmriArama,
                              iconName: Icons.content_paste_off,
                              navigator: CloseRequestAwaitApproval()),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeButton(
                              text: 'Yeni İş Emri',
                              iconName: Icons.calendar_month,
                              navigator: ComplaintRequests()),
                        ),
                        // Expanded(
                        //   child: HomeButton(
                        //       text: 'Kapatılmış Taleplerim',
                        //       iconName: Icons.attachment,
                        //       navigator: ClosedRequests()),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
