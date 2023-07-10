<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';
=======
import 'themes.dart';
>>>>>>> 7c825ae1c3be870afca98609aae6bca89bc40b8e

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
