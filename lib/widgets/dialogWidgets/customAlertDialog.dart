import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

CustomAlertDialog(
    BuildContext context,
    VoidCallback? onConfirm,
    String title,
    String text,
    ArtSweetAlertType type,
    String confirmButtonText,
    String denyButtonText) {
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
          denyButtonText: denyButtonText,
          onCancel: () {
            Navigator.pop(context);
          },
          onConfirm: onConfirm));
}
