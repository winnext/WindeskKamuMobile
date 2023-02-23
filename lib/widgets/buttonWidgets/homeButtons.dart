import 'package:flutter/material.dart';

import '../../utils/themes.dart';

class HomeButton extends StatelessWidget {
  final String? text;
  final IconData? iconName;
  final String? navigator;

  const HomeButton({this.iconName, this.navigator, this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width / 4.5,
          height: MediaQuery.of(context).size.width / 4.5,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, navigator!);
            },
            child: Icon(
              iconName,
              size: MediaQuery.of(context).size.width / 10,
              color: APPColors.Accent.blue,
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(APPColors.Secondary.blue),
              minimumSize: MaterialStateProperty.all(Size.square(60)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(2),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 8),
                  side: BorderSide(color: APPColors.Secondary.blue),
                ),
              ),
            ),
          ),
        ),
        Text(
          text!,
          style: TextStyle(fontSize: 15, color: APPColors.Accent.blue),
        ),
      ],
    );
  }
}
