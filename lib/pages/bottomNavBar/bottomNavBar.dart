import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../providers/main_page_view_provider.dart';
import '../../utils/themes.dart';
import '../WorkOrder/WoCreate.dart';
import '../homePage.dart';
import '../internet_connection/internet_connection.dart';
import '../searchPage/searchPage.dart';
import '../test/test.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    final mainViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);
    print(mainViewProvider.currentIndex);

    mainViewProvider.initForm();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [const MyHomePage(), const WoCreate(), const searchPage(), const Test()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Anasayfa"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: APPColors.Main.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add_box),
          title: ("Yeni İş Emri"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: APPColors.Main.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: ("Arama"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: APPColors.Main.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.wifi),
          title: ("Test"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: APPColors.Main.grey,
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
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

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
