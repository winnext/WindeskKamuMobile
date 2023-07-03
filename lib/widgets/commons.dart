import 'package:flutter/material.dart';
import '../utils/themes.dart';
import '../utils/utils.dart';

//Boşluk bırakmak için kullanılacak olan widget
// [...] => opsiyonel kullanım
Widget spaceArea(double? height, [double? width]) {
  return SizedBox(
    height: height,
    width: width,
  );
}

//Divider
Widget customDivider(double? padding, [Color? color]) {
  return Padding(
    padding: EdgeInsets.all(padding ?? 13.0),
    child: Divider(
      thickness: 1,
      indent: 0,
      endIndent: 0,
      color: color ?? mainGreyColor,
    ),
  );
}

Widget logoHeader() {
  return Align(
      alignment: Alignment.bottomLeft,
      child: Image.asset(
        APPImages.splashScreen.images,
      ));
}
