import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OpenRequests extends StatefulWidget {
  static String openRequest = '/openRequest';
  const OpenRequests({super.key});

  @override
  State<OpenRequests> createState() => _OpenRequestsState();
}

class _OpenRequestsState extends State<OpenRequests> {
  @override
  Widget build(BuildContext context) {
    return ListOpen();
  }
}

Widget ListOpen() {
  return Column(
    children: <Widget>[
      Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Text(
              'asd',
            ),
          ),
        ),
      )
    ],
  );
}
