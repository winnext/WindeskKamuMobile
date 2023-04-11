import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/routeRequests.dart';
import 'package:win_kamu/pages/closedRequests/routeRequests.dart';
import 'package:win_kamu/pages/complaintRequests/routeRequests.dart';
import 'package:win_kamu/pages/internet_connection/internet_connection.dart';
import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/pages/new_notif/new_notif.dart';
import 'package:win_kamu/pages/plannedRequests/routeRequests.dart';
import 'package:win_kamu/pages/splash_screen/splash_view.dart';
import '../widgets/buttonWidgets/homeButtons.dart';
import 'package:badges/badges.dart' as badges;
import '../utils/themes.dart';
import 'issue/routeIssue.dart';
import 'openRequests/RouteRequests.dart';

class MyHomePage extends StatefulWidget {
  static String homePage = '/homePage';

  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
