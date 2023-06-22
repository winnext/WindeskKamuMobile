// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors, sort_child_properties_last

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:win_kamu/pages/login/login.dart';
import 'package:win_kamu/utils/utils.dart';
import '../l10n/locale_keys.g.dart';
import '../widgets/customDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/customLoadingScreenDialog.dart';
import '../widgets/dialogWidgets/customDialogOnlyConfirm.dart';

Future logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => CustomDialog(
            cancelFunction: () {
              Navigator.pop(context);
            },
            confirmButtonText: LocaleKeys.evet.tr(),
            description: LocaleKeys.cikisYapilacaktir.tr(),
            okFunction: () async {
              prefs.clear();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
            },
            onlyConfirmation: false,
            cancelButtonText: LocaleKeys.vazgec.tr(),
          ));
}

void baglantiHatasi(BuildContext context, String? message) async {
  CustomAlertDialogOnlyConfirm(context, () {
    Navigator.pop(context);
  }, LocaleKeys.birHataMeydanaGeldi.tr(), message!, ArtSweetAlertType.danger, LocaleKeys.tamam.tr());
}

void snackBar(BuildContext context, String message, String type) async {
  if (type == 'info') {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: message,
      ),
    );
  } else if (type == 'success') {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
  } else if (type == 'error') {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
      ),
    );
  } else if (type == 'connect') {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.connect(
        message: message,
      ),
    );
  } else if (type == 'notconnect') {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.notconnect(
          message: message,
        ),
        displayDuration: Duration(hours: 2));
  } else if (type == 'true') {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
        ),
        displayDuration: Duration(seconds: 3));
  } else if (type == 'false') {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
        ),
        displayDuration: Duration(seconds: 3));
  } else {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
        ),
        displayDuration: Duration(seconds: 3));
  }
}

Widget loadingBar(BuildContext context, Color? backgroundcolor, Color? textColor) {
  return CustomLoadingScreen(backgroundColor: backgroundcolor, textColor: textColor);
}

Color generateColor(int l) {
  return Listcolors[l];
}

Widget pageCard(BuildContext context, String cardName, Widget cardIcon) {
  return SizedBox(
      height: MediaQuery.of(context).size.height / 7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: (BoxDecoration(
            color: Color(0xffF7F7F7),
            border: Border.all(
              color: Color(0xffB4B4B4),
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardIcon,
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
                    child: Text(
                      cardName,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.height / 45),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ));
}
//-----------------VALIDATORS-----------------------------
// ignore_for_file: body_might_complete_normally_nullable

String? formBos(String? fieldContent) {
  if (fieldContent == "" || fieldContent == null) {
    return LocaleKeys.buAlanBosOlamaz.tr();
  } else {
    if (fieldContent.length < 3) {
      return LocaleKeys.buAlanUcKarakterdenAzOlamaz.tr();
    }
  }
}

String? formEmail(String? fieldContent) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);

  if (regExp.hasMatch(fieldContent!)) {
    return null;
  } else {
    return LocaleKeys.emailFormatiKontrolEdiniz.tr();
  }
}

String? formText(String? fieldContent) {
  if (fieldContent!.length < 3) {
    return LocaleKeys.buAlanUcKarakterdenAzOlamaz.tr();
  } else {
    return null;
  }
}

String? formDropdown(String? fieldContent) {
  if (fieldContent == null) {
    return LocaleKeys.lutfenSecimYapiniz.tr();
  } else {
    null;
  }
}

String? formPassword(String? fieldContent) {
  if (fieldContent!.isNotEmpty) {
    null;
  } else {
    return LocaleKeys.lutfenSifreniziGiriniz.tr();
  }
}

String? formTC(String? fieldContent) {
  if (fieldContent!.isNotEmpty) {
    if (fieldContent.length < 11) {
      return LocaleKeys.lutfenTcGiriniz.tr();
    }
  } else {
    return LocaleKeys.buAlanBosOlamaz.tr();
  }
}

String? formTCLength(String? fieldContent) {
  if (fieldContent!.isNotEmpty) {
    if (fieldContent.length < 11) {
      return LocaleKeys.lutfenTcGiriniz.tr();
    }
  }
}

String? formPhone(String? fieldContent) {
  final p = RegExp(r'^^[1-9][0-9]*$');
  if (fieldContent!.isNotEmpty) {
    if (!p.hasMatch(fieldContent) || fieldContent.length < 10) {
      return LocaleKeys.telefonNumaraniziGiriniz.tr();
    }
  } else {
    return LocaleKeys.buAlanBosOlamaz.tr();
  }
}

String? formPhoneWithHolder(String? fieldContent) {
  if (fieldContent!.isNotEmpty) {
    print(fieldContent[2]);
    if (fieldContent[2] == "0") {
      return LocaleKeys.telefonNumaraniziGiriniz.tr();
    }
  } else {
    return LocaleKeys.buAlanBosOlamaz.tr();
  }
}

String? formLength(String? fieldContent) {
  if (fieldContent!.length < 3) {
    return LocaleKeys.buAlanUcKarakterdenAzOlamaz.tr();
  }
}
