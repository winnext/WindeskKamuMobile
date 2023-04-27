import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/routeRequests.dart';
import 'package:win_kamu/pages/closedRequests/routeRequests.dart';
import 'package:win_kamu/pages/complaintRequests/routeRequests.dart';
import 'package:win_kamu/pages/internet_connection/internet_connection.dart';
import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/pages/new_notif/new_notif.dart';
import 'package:win_kamu/pages/notiService.dart';
import 'package:win_kamu/pages/plannedRequests/routeRequests.dart';
import 'package:win_kamu/pages/splash_screen/splash_view.dart';
import '../widgets/buttonWidgets/homeButtons.dart';
import 'package:badges/badges.dart' as badges;
import '../utils/themes.dart';
import 'issue/routeIssue.dart';
import 'openRequests/RouteRequests.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';


class MyHomePage extends StatefulWidget {
  static String homePage = '/homePage';

  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  showAlertDialog(BuildContext context, title,body,module,code) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("İptal"),
    onPressed:  () {
      Navigator.of(context, rootNavigator: true).pop('dialog');  
  },
  );
  Widget continueButton = TextButton(
    child: Text("Talebe Git"),
    onPressed:  () {},
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


const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('@mipmap/ic_launcher');

final IOSInitializationSettings initializationSettingsIOS =  const IOSInitializationSettings(
  requestAlertPermission: true,
  requestBadgePermission: true,
  requestSoundPermission: true,
  );

final MacOSInitializationSettings initializationSettingsMacOS = const MacOSInitializationSettings();

final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
  macOS: initializationSettingsMacOS);


   flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: ((data) async{
    onNotifications.add(data);
  }));

   void onClickedNotification(String? payload){
          print('Foreground HOME Payload : '+payload.toString());
          String data = payload.toString();
          final splitted_data = data.split('/-*-/');
          String title = splitted_data[0];
          String body = splitted_data[1];
          String module = splitted_data[2];
          String code = splitted_data[3];

      showAlertDialog(context,title,body,module,code);


          

  }

  


  onNotifications.stream.listen(onClickedNotification);


// Lisitnening to the background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
  await Firebase.initializeApp();
  
  print("Handling a background message: ${message.messageId}");
}

// Lisitnening to the background messages
WidgetsFlutterBinding.ensureInitialized();
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Listneing to the foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
    
    print('Got a message whilst in the foreground!');
    print('Message data Home: ${message.data}');

    var payload = (message.notification?.title).toString()+'/-*-/'+(message.notification?.body).toString()+'/-*-/'+message.data?['module']+'/-*-/'+message.data?['code'];
  
   NotificationApi.showNotification(title:message.notification?.title,body:message.notification?.body,payload:payload);

   
  });


  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('HomePage');
      print('Firebase notification opened');
      showAlertDialog(context,message.notification?.title,message.notification?.body,message.data?['module'],message.data?['code']);
      //FlutterLocalNotificationsPlugin().show(message.notification.messageId, message.notification?.title, message.notification?.body,);
  });

    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {


   
 


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
              onPressed: () {},
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: APPColors.Main.white,
          leading: Builder(
            builder: (BuildContext context) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 35,
                    color: APPColors.Main.black,
                  ),
                  onPressed: () {},
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
                                text: 'Vaka-(SLA) Listesi',
                                iconName: Icons.calendar_month,
                                navigator: Issue()),
                          ),
                          Expanded(
                            child: HomeButton(
                                text: 'Vaka-(SLA) Arama',
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
                                text: 'İş Emri Listesi',
                                iconName: Icons.content_paste_search,
                                navigator: OpenRequests()),
                          ),
                          Expanded(
                            child: HomeButton(
                                text: 'İş Emri Arama ',
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
                                navigator: ComplaintRequests() ),
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
      ),
    );
  }
}
