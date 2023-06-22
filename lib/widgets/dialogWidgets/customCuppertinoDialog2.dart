// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomCuppertinoDialog2(BuildContext context, String header, String subHeader, String okText, VoidCallback okPress) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(header, style: const TextStyle(fontWeight: FontWeight.w600)),
        content: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Text(subHeader, style: const TextStyle(fontWeight: FontWeight.w400)),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
              onPressed: okPress, child: Text(okText, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, letterSpacing: 0.3))),
        ],
      );
    },
  );
}
