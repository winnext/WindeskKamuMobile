// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomCuppertinoDialogs1(
    BuildContext context, String header, String subHeader, String okText, String denyText, VoidCallback okPress, VoidCallback denyPress) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          header,
          style: const TextStyle(height: 1.2, fontWeight: FontWeight.w600),
        ),
        content: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Text(
            subHeader,
            style: const TextStyle(height: 1.2, fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: denyPress,
            child: Text(denyText, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, letterSpacing: 0.3)),
          ),
          CupertinoDialogAction(
            onPressed: okPress,
            child: Text(okText, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, letterSpacing: 0.3)),
          ),
        ],
      );
    },
  );
}
