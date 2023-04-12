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
      timeInfoNow,
      ani,
      id,
      plannedDate,
      contactName,
      locName,
      locTree,
      locTree2,
      title,
      cmdb,
      hys,
      hds,
      assignmentGroup,
      assignmentGroupName,
      assigneName,
      relatedCode,
      cat1,
      contactCode,
      plannedDesc,
      slaCode,
      parentStatus,
      wrondDirect,
      respondedDate,
      respondedTimer,
      fixedDate,
      fixTimer;

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
      this.timeInfoNow,
      this.ani,
      this.assigneName,
      this.assignmentGroup,
      this.assignmentGroupName,
      this.cat1,
      this.cmdb,
      this.contactCode,
      this.contactName,
      this.hds,
      this.hys,
      this.id,
      this.locName,
      this.locTree,
      this.locTree2,
      this.parentStatus,
      this.plannedDate,
      this.plannedDesc,
      this.relatedCode,
      this.slaCode,
      this.title,
      this.wrondDirect,
      this.fixTimer,
      this.fixedDate,
      this.respondedDate,
      this.respondedTimer})
      : super(key: key);

  @override
  State<DetailListWidget> createState() => _DetailListWidgetState();
}

class _DetailListWidgetState extends State<DetailListWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        widget.onPressed(widget.code.toString());
      },
      child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        widget.statusCode == 'OPlanned'
                            ? Container(
                                decoration: BoxDecoration(
                                    color: APPColors.NewNotifi.blue,
                                    borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.all(3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Randevulu Vakadır'),
                                    Text(widget.planedDate.toString()),
                                  ],
                                ),
                              )
                            : widget.respondedTimer == '1'
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3)),
                                    padding: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Hedef Yanıtlama Tarihi'),
                                        Text(
                                          timeRecover(widget.targetRDate)
                                              .toString(),
                                          style: fixStyle(
                                              widget.respondedTimer.toString(),
                                              widget.fixTimer.toString(),
                                              widget.targetFDate.toString(),
                                              widget.fixedDate.toString()),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3)),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    padding: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Yanıtlama Tarihi'),
                                        Text(
                                          timeRecover(widget.respondedDate)
                                              .toString(),
                                          style: fixStyle(
                                              widget.respondedTimer.toString(),
                                              widget.fixTimer.toString(),
                                              widget.targetFDate.toString(),
                                              widget.fixedDate.toString()),
                                        ),
                                      ],
                                    ),
                                  ),
                      ],
                    ),
                    Column(children: [
                      widget.fixTimer == '1'
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3)),
                              padding: EdgeInsets.all(3),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Hedef Düzeltme Tarihi'),
                                  Text(
                                    timeRecover(widget.targetFDate).toString(),
                                    style: fixStyle(
                                        widget.respondedTimer.toString(),
                                        widget.fixTimer.toString(),
                                        widget.targetFDate.toString(),
                                        widget.fixedDate.toString()),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3)),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              padding: EdgeInsets.all(3),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Düzeltme Tarihi'),
                                  Text(
                                    timeRecover(widget.fixedDate).toString(),
                                    style: fixStyle(
                                        widget.respondedTimer.toString(),
                                        widget.fixTimer.toString(),
                                        widget.targetFDate.toString(),
                                        widget.fixedDate.toString()),
                                  ),
                                ],
                              ),
                            ),
                    ])
                  ],
                ),
              ),
              Divider(height: 15, color: APPColors.Main.black),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.code.toString(),
                      style: TextStyle(
                        color: APPColors.Secondary.black,
                        fontSize: 15,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.idate.toString(),
                      style: TextStyle(
                        color: APPColors.Secondary.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.statusName.toString(),
                      style: TextStyle(
                        color: APPColors.Secondary.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 15,
              ),
              widget.description.toString() != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Vaka Sahibi',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.contactName.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.locName.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Mahal',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.locName.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.locName.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Mahal Yeri',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.locTree.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.title.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Arama Nedeni',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.title.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.cmdb.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Varlık Bilgisi',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.title.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.idate.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Açılma Tarihi',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.idate.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.ani.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Arayan Numara',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.ani.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.targetRDate.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Hedef Yanıtlama',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.targetRDate.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.targetFDate.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Hedef Düzeltme',
                            style: TextStyle(
                              color: APPColors.Secondary.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.targetFDate.toString(),
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
              widget.hys.toString() != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'HYS-48 saat ${widget.hys.toString()}',
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'HDS-48 saat ${widget.hds.toString()}',
                            style: TextStyle(
                                color: APPColors.Secondary.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
