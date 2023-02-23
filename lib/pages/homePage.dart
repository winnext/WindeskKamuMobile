import 'package:flutter/material.dart';
import 'package:win_kamu/widgets/buttonWidgets/homeButtons.dart';
import 'package:badges/badges.dart' as badges;
import '../utils/themes.dart';
import 'openRequests/openRequests.dart';

class MyHomePage extends StatefulWidget {
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
            'lib/assets/windesk.jpg',
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
              Expanded(
                  flex: 3,
                  child: Image.asset(
                    'lib/assets/home.jpg',
                    height: MediaQuery.of(context).size.width / 1,
                    width: MediaQuery.of(context).size.width / 1,
                    fit: BoxFit.cover,
                    //color: Colors.amber,
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
                                text: 'Açık Taleplerim',
                                iconName: Icons.content_paste_search,
                                navigator: OpenRequests.openRequest),
                          ),
                          Expanded(
                            child: HomeButton(
                                text: 'Kapatma Onayı Bekleyenler',
                                iconName: Icons.content_paste_off,
                                navigator: OpenRequests.openRequest),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: HomeButton(
                                text: 'Bu Ayın Planı',
                                iconName: Icons.calendar_month,
                                navigator: OpenRequests.openRequest),
                          ),
                          Expanded(
                            child: HomeButton(
                                text: 'Yeni Bildirim',
                                iconName: Icons.attachment,
                                navigator: OpenRequests.openRequest),
                          )
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
