import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../providers/main_page_view_provider.dart';
import '../../utils/themes.dart';

class SearchButton extends StatelessWidget {
  final String? text;
  final IconData? iconName;
  final navigator;

  const SearchButton({this.iconName, this.navigator, this.text, super.key});

  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);
    final size = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: size / 9,
          height: size / 9,
          child: ElevatedButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: navigator,
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(APPColors.Secondary.blue),
              minimumSize: MaterialStateProperty.all(const Size.square(60)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(2),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 8),
                  side: BorderSide(color: APPColors.Secondary.blue),
                ),
              ),
            ),
            child: Icon(
              iconName,
              size: MediaQuery.of(context).size.width / 10,
              color: APPColors.Accent.blue,
            ),
          ),
        ),
        Center(
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 15,
              color: APPColors.Accent.blue,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
