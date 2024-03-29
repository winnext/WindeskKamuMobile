//Uygulama içerisinde kullanılacak imajların merkezi olarak yönetilmesi için oluşturulmuştur.
//Buraya ekleme yapmadan önce pubspec.yaml dosyasına imajın yolu verilmesi gerekmektedir.
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum APPImages {
  splashScreen,
  defaultImage,
  turkishIcon,
  englishIcon,
  homeImage,
}

extension APPImagesExtension on APPImages {
  String get images {
    switch (this) {
      case APPImages.splashScreen:
        return "lib/assets/images/logo.png";
      case APPImages.defaultImage:
        return "lib/assets/images/example_image.png";
      case APPImages.turkishIcon:
        return "lib/assets/images/icons/turkey-icon.png";
      case APPImages.englishIcon:
        return "lib/assets/images/icons/english-icon.png";
      case APPImages.homeImage:
        return "lib/assets/images/home.png";
    }
  }
}

enum APPColors { Login, Main, Secondary, Accent, Graident, NewNotifi, Modal, TracingNumber, Clear, Filter, Timer }

extension APPColorsExtension on APPColors {
  Color get orange {
    switch (this) {
      case APPColors.Main:
        return const Color.fromARGB(255, 23, 157, 224);
      case APPColors.Secondary:
        return const Color(0xffF9BA59);
      case APPColors.Accent:
        return const Color(0xffFFCC7E);
      default:
        return const Color(0xffF9AA33);
    }
  }

  Color get green {
    switch (this) {
      case APPColors.Main:
        return const Color(0xff80ed99);
      case APPColors.Secondary:
        return const Color(0xff38b000);
      case APPColors.Accent:
        return const Color(0xffFFCC7E);
      default:
        return const Color(0xffF9AA33);
    }
  }

  Color get blue {
    switch (this) {
      case APPColors.Login:
        return const Color.fromARGB(1000, 33, 173, 228); //0xff1c5794
      case APPColors.Main:
        return const Color.fromARGB(255, 48, 105, 211); //0xff1c5794
      case APPColors.Secondary:
        return const Color(0xffA5E5FF);
      case APPColors.Accent:
        return const Color(0xff184888);
      case APPColors.Modal:
        return const Color(0xff4F5D6B);
      case APPColors.NewNotifi:
        return const Color.fromARGB(1000, 165, 229, 255);
      case APPColors.TracingNumber:
        return const Color(0xff44B6C8);
      case APPColors.Clear:
        return const Color(0xff21ADE4);
      case APPColors.Filter:
        return const Color(0xff98D6EE);
      default:
        return const Color(0xff4a6572);
    }
  }

  Color get grey {
    switch (this) {
      case APPColors.Main:
        return const Color(0xffABABAB);
      case APPColors.Secondary:
        return const Color(0xFF776E6E);
      case APPColors.Accent:
        return const Color.fromARGB(140, 255, 255, 255);
      case APPColors.NewNotifi:
        return const Color.fromARGB(1000, 243, 244, 255);
      default:
        return const Color(0xffABABAB);
    }
  }

  Color get black {
    switch (this) {
      case APPColors.Main:
        return const Color(0xff515151);
      case APPColors.Secondary:
        return const Color(0xFF242D31);
      default:
        return const Color(0xff515151);
    }
  }

  Color get white {
    switch (this) {
      case APPColors.Main:
        return const Color(0xffFFFDFD);
      case APPColors.Secondary:
        return const Color(0xffedede9);
      default:
        return const Color(0xffFFFDFD);
    }
  }

  Color get red {
    switch (this) {
      case APPColors.Main:
        return Colors.redAccent;
      case APPColors.Secondary:
        return const Color(0xfff55138);
      case APPColors.NewNotifi:
        return const Color.fromARGB(1000, 237, 181, 181);
      case APPColors.Timer:
        return const Color(0xffe71d36);
      default:
        return Colors.red;
    }
  }
}
