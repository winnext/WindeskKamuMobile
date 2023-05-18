// ignore_for_file:file_names, prefer_const_constructors_in_immutables,prefer_const_constructors,prefer_const_literals_to_create_immutables,use_key_in_widget_constructors

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

import '../../utils/time_utils.dart';
import '../../utils/utils.dart';

class WoListWidget extends StatefulWidget {
  final String? id,
      code,
      statusName,
      service,
      serviceName,
      moduleLocation,
      name,
      responsible,
      plannedEndDate;

  final Color? importanceLevelColor;
  final VoidCallback? press;
  final bool isIcon;
  final Function onPressed;
  final Function onPressedLong;

  const WoListWidget(
      {Key? key,
      this.code,
      this.id,
      this.moduleLocation,
      this.name,
      this.plannedEndDate,
      this.service,
      this.responsible,
      this.serviceName,
      this.importanceLevelColor,
      this.statusName,
      this.press,
      this.isIcon = false,
      required this.onPressed,
      required this.onPressedLong})
      : super(key: key);

  @override
  State<WoListWidget> createState() => _WoListWidgetState();
}

class _WoListWidgetState extends State<WoListWidget> {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      width: size.width/1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              widget.code.toString(),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              widget.statusName.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: APPColors.Secondary.black,
                                fontSize: 13,
                          ),
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black
                  ),
                  Container(
                    width: size.width/1.2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                    '${widget.serviceName.toString()}',
                    style: TextStyle(
                          color: APPColors.Secondary.black,
                      fontSize: 14,
                    ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 20,
                  ),
                  Container(
                    width: size.width/1.2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                    '${widget.name.toString()}',
                    style: TextStyle(
                          color: APPColors.Secondary.black,
                      fontSize: 14,
                    ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width/1.2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                    '${widget.moduleLocation.toString()}',
                    style: TextStyle(
                          color: APPColors.Secondary.black,
                      fontSize: 14,
                    ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width/1.2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                    '${widget.moduleLocation.toString()}',
                    style: TextStyle(
                          color: APPColors.Secondary.black,
                      fontSize: 14,
                    ),
                      ),
                    ),
                  ),                          
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
