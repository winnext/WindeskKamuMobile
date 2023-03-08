// ignore_for_file:file_names, prefer_const_constructors_in_immutables,prefer_const_constructors,prefer_const_literals_to_create_immutables,use_key_in_widget_constructors

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

import '../../utils/time_utils.dart';
import '../../utils/utils.dart';

class DetailListWidget extends StatefulWidget {
  final String? code,
      targetFDate,
      targetRDate,
      taskNo,
      description,
      sumdesc1,
      statusName,
      space,
      location,
      idate,
      statusCode,
      planedDate,
      respondedIDate,
      responseTimer,
      fixedTimer,
      fixedIDate,
      timeInfoNow;

  final Color? importanceLevelColor;
  final VoidCallback? press;
  final bool isIcon;
  final Function onPressed;

  const DetailListWidget(
      {Key? key,
      this.code,
      this.targetFDate,
      this.targetRDate,
      this.space,
      this.taskNo,
      this.description,
      this.sumdesc1,
      this.press,
      this.importanceLevelColor,
      this.statusName,
      this.isIcon = false,
      this.location,
      this.idate,
      this.statusCode,
      this.planedDate,
      required this.onPressed,
      this.respondedIDate,
      this.fixedTimer,
      this.responseTimer,
      this.fixedIDate,
      this.timeInfoNow})
      : super(key: key);

  @override
  State<DetailListWidget> createState() => _DetailListWidgetState();
}

class _DetailListWidgetState extends State<DetailListWidget> {
  String dateNow = DateFormat("yyyyMMddhhmmss").format(DateTime.now());

  changeTime() {
    setState(() {
      dateNow = DateFormat("yyyyMMddhhmmss").format(DateTime.now());
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      changeTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        widget.onPressed(widget.code.toString());
      },
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x19025273),
              blurRadius: 12,
              offset: Offset(6, 8),
            ),
          ],
          color: Color(0xfff6f6f6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 12, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Container(
                      color: widget.importanceLevelColor!,
                      width: MediaQuery.of(context).size.width / 50,
                      height: MediaQuery.of(context).size.height / 12,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: size.width / 2.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.code.toString(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff025273),
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: size.width / 1.5,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          widget.statusName.toString(),
                          style: TextStyle(
                            color: Color(0xff025273),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.description.toString() != ""
                      ? Flexible(
                          child: SizedBox(
                            width: size.width / 1.5,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                widget.description.toString(),
                                style: TextStyle(
                                  color: Color(0xff025273),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 6),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
