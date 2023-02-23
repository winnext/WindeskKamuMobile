import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';

import '../../utils/themes.dart';

CustomAlertDialogOnlyConfirm(
  BuildContext context,
  VoidCallback? onConfirm,
  String title,
  String text,
  ArtSweetAlertType type,
  String confirmButtonText,
) {
  return ArtSweetAlert.show(
      barrierDismissible: false,
      context: context,
      artDialogArgs: ArtDialogArgs(
          cancelButtonColor: APPColors.Main.red,
          confirmButtonColor: APPColors.Main.blue,
          type: type,
          title: title,
          text: text,
          confirmButtonText: confirmButtonText,
          onConfirm: onConfirm));
}
