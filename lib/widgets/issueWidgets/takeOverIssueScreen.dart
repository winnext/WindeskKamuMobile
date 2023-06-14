import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../providers/list_view_provider.dart';
import '../../utils/themes.dart';

class TakeOverIssue extends StatefulWidget {
  VoidCallback? onConfirm;
  String? title;
  String? text;
  bool? success;
  String? confirmButtonText;
  
  TakeOverIssue(
      {this.onConfirm,
      this.title,
      this.text,
      this.success,
      this.confirmButtonText,
      super.key});

  @override
  State<TakeOverIssue> createState() => _TakeOverIssueState();
}

class _TakeOverIssueState extends State<TakeOverIssue> {
  String? selectedFruit;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Column(
          children: [
            // widget.success == true
            //     ? SuccessIcon(
            //         size: MediaQuery.of(context).size.height / 9,
            //       )
            //     : WarningIcon(size: MediaQuery.of(context).size.height / 9),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(89, 89, 89, 1), fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.text.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(89, 89, 89, 1), fontSize: 15),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: widget.onConfirm,
            child: Text(
              widget.confirmButtonText.toString(),
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
