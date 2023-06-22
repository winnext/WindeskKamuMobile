// ignore_for_file: avoid_print

import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:win_kamu/utils/global_utils.dart';

internetConnection(context) async {
  // Simple check to see if we have internet

  var durum = 1;

  InternetConnectionChecker().addresses = <AddressCheckOptions>[
    AddressCheckOptions(
      address: InternetAddress(
        '1.1.1.1', //10.86.4.46 aeh
        // 1.1.1.1 cihaz interneti
        type: InternetAddressType.IPv4,
      ),
      port: 80,
    ),
  ];

  var listener = InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        print('Data connection is available.');
        if (durum != 1) {
          snackBar(context, 'İnternet bağlantısı sağlandı. ', 'connect');
        }
        break;
      case InternetConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        durum = 0;
        print(context.state);
        snackBar(context, 'İnternet bağlantısı bulunamadı. Lütfen kontrol ediniz.', 'notconnect');
        break;
    }
  });
}
