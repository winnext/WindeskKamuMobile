import 'themes.dart';

colorCalculator(String numberone, String numbertwo) {
  if (int.parse(numberone) - int.parse(numbertwo) < 0) {
    return APPColors.Secondary.green;
  } else {
    return APPColors.Timer.red;
  }
}

colorCalculatorBackground(String numberone, String numbertwo) {
  if (int.parse(numberone) - int.parse(numbertwo) < 0) {
    return APPColors.Main.green;
  } else {
    return APPColors.Main.red;
  }
}

colorCalculatorText(String numberone, String numbertwo) {
  if (int.parse(numberone) - int.parse(numbertwo) < 0) {
    return APPColors.Main.black;
  } else {
    return APPColors.Main.white;
  }
}
