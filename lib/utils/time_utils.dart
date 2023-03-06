import 'package:easy_localization/easy_localization.dart';

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
      '${date3.inDays} gün ${int.parse(date3.inHours.toString()) % 24} saat ${int.parse(date3.inMinutes.toString()) % 60} dakika ${int.parse(date3.inSeconds.toString()) % 60} saniye ';

  return finalDuration;
}
