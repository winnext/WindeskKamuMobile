// ignore_for_file:file_names, prefer_const_constructors_in_immutables,prefer_const_constructors,prefer_const_literals_to_create_immutables,use_key_in_widget_constructors

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

import '../../utils/color_Utils.dart';
import '../../utils/time_utils.dart';

class TaskListWidget extends StatefulWidget {
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
  final Function onPressedLong;

  const TaskListWidget(
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
      this.timeInfoNow,
      required this.onPressedLong})
      : super(key: key);

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  String dateNow = DateFormat("yyyyMMddhhmmss").format(DateTime.now());

  changeTime() {
    if (mounted) {
      setState(() {
        dateNow = DateFormat("yyyyMMddhhmmss").format(DateTime.now());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      changeTime();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    changeTime().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        widget.onPressed(widget.code.toString());
      },
      onLongPress: () {
        widget.onPressedLong();
        print('object');
      },
      child: Container(
        width: size.width / 1.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x19025273),
              blurRadius: 50,
              offset: Offset(6, 8),
            ),
          ],
          color: APPColors.Main.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 12, right: 8, bottom: 8),
          child: Column(
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
                  width: size.width / 1,
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
              Divider(
                height: 5,
              ),
              widget.location.toString() != ""
                  ? Flexible(
                      child: SizedBox(
                        width: size.width / 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.location.toString(),
                            style: TextStyle(
                              color: Color(0xff025273),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Divider(
                height: 5,
              ),
              widget.space.toString() != ""
                  ? Flexible(
                      child: SizedBox(
                        width: size.width / 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.space.toString(),
                            style: TextStyle(
                              color: Color(0xff025273),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              widget.description.toString() != ""
                  ? Flexible(
                      child: SizedBox(
                        width: size.width / 1,
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
              Flexible(
                child: SizedBox(
                  width: size.width / 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Açılma Tarihi:  ${widget.idate.toString()}',
                      style: TextStyle(
                        color: Color(0xff025273),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              widget.statusCode.toString() == "OPlanned"
                  ? Flexible(
                      child: SizedBox(
                        width: size.width / 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Randevulu Vaka ${timeRecover(widget.planedDate)}',
                            style: TextStyle(
                              color: Color(0xff025273),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  : widget.responseTimer == "0" && widget.fixedTimer == "0"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: size.width / 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: colorCalculatorBackground(widget.respondedIDate.toString(), widget.targetRDate.toString())),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Gerçekleşen Yanıtlama ${timeRecover(widget.respondedIDate).toString()}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.5,
                                            color: colorCalculatorText(widget.respondedIDate.toString(), widget.targetRDate.toString()),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            widget.fixedIDate == ''
                                ? Flexible(
                                    child: SizedBox(
                                      width: size.width / 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 0.0),
                                        child: Container(
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: colorCalculatorBackground('5000000000000000', (widget.targetFDate).toString())),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Düzeltme tarihine ulaşılamadı.',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  letterSpacing: 0.5,
                                                  color: colorCalculatorText('5000000000000000', (widget.targetFDate).toString()),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Flexible(
                                    child: SizedBox(
                                      width: size.width / 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 0.0),
                                        child: Container(
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: colorCalculatorBackground((widget.fixedIDate).toString(), (widget.targetFDate).toString())),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Gerçekleşen Düzeltme ${timeRecover(widget.fixedIDate).toString()}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  letterSpacing: 0.5,
                                                  color: colorCalculatorText((widget.fixedIDate).toString(), (widget.targetFDate).toString()),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        )
                      : widget.responseTimer == "0" && widget.fixedTimer == "1"
                          ? Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width / 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        height: size.height / 22,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: colorCalculatorBackground(widget.respondedIDate.toString(), widget.targetRDate.toString())),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Gerçekleşen Yanıtlama ${timeRecover(widget.respondedIDate.toString())}',
                                            style: TextStyle(
                                                fontSize: 13,
                                                letterSpacing: 0.5,
                                                color: colorCalculatorText(widget.respondedIDate.toString(), widget.targetRDate.toString()),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 1.1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Hedef Düzeltme ${timeRecover(widget.targetFDate.toString())}',
                                        style: TextStyle(
                                          color: colorCalculator(dateNow.toString(), widget.targetFDate.toString()),
                                          fontSize: 13,
                                          overflow: TextOverflow.ellipsis,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 1.1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Kalan Süreniz ${timeDifference(widget.targetFDate)}',
                                        style: TextStyle(
                                          color: colorCalculator(dateNow.toString(), widget.targetFDate.toString()),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width / 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Hedef Yanıtlama ${timeRecover(widget.targetRDate.toString())}',
                                        style: TextStyle(
                                          color: colorCalculator(dateNow.toString(), widget.targetRDate.toString()),
                                          fontSize: 13,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Kalan Süreniz ${timeDifference(widget.targetRDate).toString()}',
                                        style: TextStyle(
                                          color: colorCalculator(dateNow.toString(), widget.targetRDate.toString()),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Hedef Düzeltme ${timeRecover(widget.targetFDate.toString())}',
                                        style: TextStyle(
                                          color: colorCalculator(dateNow.toString(), widget.targetFDate.toString()),
                                          fontSize: 13,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Kalan Süreniz ${timeDifference(widget.targetFDate).toString()}',
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          color: colorCalculator(dateNow.toString(), widget.targetFDate.toString()),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
            ],
          ),
        ),
      ),
    );
  }
}
