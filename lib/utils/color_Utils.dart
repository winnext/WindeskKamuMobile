import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

class CustomColorCalculator {
  Color colorCalculator(String numberone, String numbertwo) {
    if (int.parse(numberone) - int.parse(numbertwo) < 0) {
      return APPColors.Secondary.green;
    } else {
      return APPColors.Timer.red;
    }
  }

  Color colorCalculatorBackground(String numberone, String numbertwo) {
    if (int.parse(numberone) - int.parse(numbertwo) < 0) {
      return APPColors.Main.green;
    } else {
      return APPColors.Main.red;
    }
  }

  Color colorCalculatorText(String numberone, String numbertwo) {
    if (int.parse(numberone) - int.parse(numbertwo) < 0) {
      return APPColors.Main.black;
    } else {
      return APPColors.Main.white;
    }
  }
}
