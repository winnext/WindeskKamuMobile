import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomDialogActionSheet(BuildContext context, String header, String subHeader,
    List<Widget> actions) {
  return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            title: Text(header,
                style:
                    TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            message: Text(subHeader,
                style:
                    TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              child: Text("Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, letterSpacing: 0.5)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ));
}

CustomDialogActionSheetButtons(BuildContext context, String header) {
  return CupertinoActionSheetAction(
    child: Text(header,
        style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
