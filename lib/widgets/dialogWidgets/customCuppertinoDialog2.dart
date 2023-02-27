import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomCuppertinoDialog2(BuildContext context, String header, String subHeader,
    String okText, VoidCallback okPress) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(header, style: TextStyle(fontWeight: FontWeight.w600)),
        content: Container(
          margin: EdgeInsets.only(top: 16),
          child: Text(subHeader, style: TextStyle(fontWeight: FontWeight.w400)),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
              child: Text(okText,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3)),
              onPressed: okPress),
        ],
      );
    },
  );
}
