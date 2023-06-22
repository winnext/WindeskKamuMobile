// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:win_kamu/pages/homePage.dart';

import 'package:provider/provider.dart';
import 'package:win_kamu/pages/new_notif/new_notif.dart';
import 'package:win_kamu/pages/openRequests/openRequests.dart';

import '../providers/main_page_view_provider.dart';
import '../utils/themes.dart';
import '../widgets/customButtomNavigation.dart';
import 'internet_connection/internet_connection.dart';

class MainPage extends StatefulWidget {
  static String mainPage = '/mainPage';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    final mainViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);
    mainViewProvider.initForm();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);

    void degis() {
      setState(() {
        mainViewProvide.setVisible = !mainViewProvide.password_visible;
      });
    }

    //print(mainViewProvide.password_visible);
    if (mainViewProvide.password_visible) {
      internetConnection(context);
      Future.delayed(Duration.zero, () async {
        degis();
      });
    }

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: mainViewProvide.pageController,
          onPageChanged: (index) {
            setState(() => mainViewProvide.setcurrentIndex = index);
          },
          children: <Widget>[MyHomePage(), ListScreen(pageController: mainViewProvide.pageController!), NewNotif(), NewNotif()],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        animationDuration: Duration(milliseconds: 350),
        selectedItemOverlayColor: APPColors.Main.blue,
        backgroundColor: APPColors.Main.white,
        selectedIndex: mainViewProvide.currentIndex,
        onItemSelected: (index) {
          print(index);
          setState(() => mainViewProvide.setcurrentIndex = index);
          mainViewProvide.pageController!.jumpToPage(index);
        },
        items: <CustomBottomNavigationBarItem>[
          /*-------------- Build tabs here -----------------*/
          CustomBottomNavigationBarItem(
              title: 'AnaSayfa', icon: Icon(Icons.home), activeColor: APPColors.Main.white, inactiveColor: APPColors.Main.grey),
          CustomBottomNavigationBarItem(
              title: 'Açık Taleplerim',
              icon: Icon(Icons.content_paste_search),
              activeColor: APPColors.Main.white,
              inactiveColor: APPColors.Main.grey),
          CustomBottomNavigationBarItem(
              title: 'Arama', icon: Icon(Icons.content_paste_off), activeColor: APPColors.Main.white, inactiveColor: APPColors.Main.grey),
          CustomBottomNavigationBarItem(
              title: 'Yeni Bildirim', icon: Icon(Icons.attachment), activeColor: APPColors.Main.white, inactiveColor: APPColors.Main.grey),
        ],
      ),
    );
  }
}
