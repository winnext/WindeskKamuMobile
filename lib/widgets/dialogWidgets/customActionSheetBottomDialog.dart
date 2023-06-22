// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

CustomDialogActionSheet(BuildContext context, String header, String subHeader, List<Widget> actions) {
  return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            title: Text(header, style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            message: Text(subHeader, style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ));
}

CustomDialogActionSheetButtons(BuildContext context, String header) {
  return CupertinoActionSheetAction(
    child: Text(header, style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
