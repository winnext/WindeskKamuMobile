import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/listWidgets/customTaskListWidget.dart';

class OpenRequests extends StatefulWidget {
  static String openRequest = '/openRequest';
  const OpenRequests({super.key});

  @override
  State<OpenRequests> createState() => _OpenRequestsState();
}

class _OpenRequestsState extends State<OpenRequests> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black12,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: TaskListWidget(
            iconOnPressed: () {},
            importanceLevelColor: Colors.green,
            trailing: "12.12.2023",
            taskNo: "Deneme",
            title: "Deneme Başlık 3",
            subTitle: "Test",
            isIcon: true,
            extraTitle: "Lorem ipsum dolor sit amet",
          ),
        ),
      ),
    );
  }
}

// Widget ListOpen() {
  
// }
