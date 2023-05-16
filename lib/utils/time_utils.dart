import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

timeRecover(timeInfo) {
  final finalTime;
  final timeZone =
      '${timeInfo.toString().substring(0, 4)}-${timeInfo.toString().substring(4, 6)}-${timeInfo.toString().substring(6, 8)}T${timeInfo.toString().substring(8, 10)}:${timeInfo.toString().substring(10, 12)}:${timeInfo.toString().substring(12, 14)}';
  if (timeZone.toString().contains(".")) {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(timeZone.toString());
    finalTime = DateFormat("dd/MM/yyyy hh:mm:ss").format(dateTime);
  } else {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(timeZone.toString());
    finalTime = DateFormat("dd/MM/yyyy hh:mm:ss").format(dateTime);
  }
  //print('finalTİme : ' + finalTime.toString());
  return finalTime;
}

timeRecover2(timeInfo) {
  final finalTime;

  final timeZone =
      '${timeInfo.toString().substring(0, 4)}-${timeInfo.toString().substring(4, 6)}-${timeInfo.toString().substring(6, 8)}T${timeInfo.toString().substring(8, 10)}:${timeInfo.toString().substring(10, 12)}:${timeInfo.toString().substring(12, 14)}';

  if (timeZone.toString().contains(".")) {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(timeZone.toString());
    finalTime = DateFormat("dd/MM/yyyy hh:mm:ss").format(dateTime);
  } else {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(timeZone.toString());
    finalTime = DateFormat("yyyy-MM-dd hh:mm:ss.SSSSSS").format(dateTime);
  }
  return finalTime;
}

timeDifference(date2) {
  final date1 = DateTime.now();
  date2 = timeRecover2(date2);
  DateTime t2 = DateTime.parse(date2);
  Duration date3 = date1.difference(t2);
  String finalDuration =
      '${date3.inDays} gün ${int.parse(date3.inHours.toString()) % 24} saat ${int.parse(date3.inMinutes.toString()) % 60} dk. ${int.parse(date3.inSeconds.toString()) % 60} sn. ';

  return finalDuration;
}

fixStyle(respondedTimer, fixTimer, targetFDate, fixedDate) {
  String dateNow = DateFormat("yyyyMMddhhmmss").format(DateTime.now());
  final conditionOfTextStyle;
  if (respondedTimer == 0 && fixTimer == 0) {
    conditionOfTextStyle =
        int.parse(fixedDate.toString()) - int.parse(targetFDate.toString()) < 0
            ? TextStyle(
                color: APPColors.Main.white,
                backgroundColor: APPColors.Main.green,
                fontSize: 13)
            : TextStyle(
                color: APPColors.Main.white,
                backgroundColor: APPColors.Main.red,
                fontSize: 13);
  } else {
    conditionOfTextStyle =
        int.parse(dateNow.toString()) - int.parse(targetFDate.toString()) < 0
            ? TextStyle(
                color: APPColors.Main.green,
                backgroundColor: APPColors.Main.white,
                fontSize: 13)
            : TextStyle(
                color: APPColors.Main.red,
                backgroundColor: APPColors.Main.white,
                fontSize: 13);
  }

  return conditionOfTextStyle;
}