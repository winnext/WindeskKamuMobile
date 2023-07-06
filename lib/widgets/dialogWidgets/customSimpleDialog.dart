// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

SimpleShowDialog(
  BuildContext context,
  VoidCallback? onConfirm,
  String title,
  String text,
  bool success,
  String confirmButtonText,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Column(
            children: [
              // success
              //     ? SuccessIcon(
              //         size: MediaQuery.of(context).size.height / 9,
              //       )
              //     : WarningIcon(size: MediaQuery.of(context).size.height / 9),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color.fromRGBO(89, 89, 89, 1), fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color.fromRGBO(89, 89, 89, 1), fontSize: 15),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: onConfirm,
              child: Text(
                confirmButtonText,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      );
    },
  );
}
