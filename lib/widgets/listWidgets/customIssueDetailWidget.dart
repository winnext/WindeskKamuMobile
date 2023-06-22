// ignore_for_file:file_names, prefer_const_constructors_in_immutables,prefer_const_constructors,prefer_const_literals_to_create_immutables,use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';
import '../../utils/time_utils.dart';

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
      fixTimer,
      xusercode;

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
      this.respondedTimer,
      this.xusercode})
      : super(key: key);

  @override
  State<DetailListWidget> createState() => _DetailListWidgetState();
}

class _DetailListWidgetState extends State<DetailListWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height / 1.8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          widget.statusCode == 'OPlanned'
                              ? Container(
                                  decoration: BoxDecoration(color: APPColors.NewNotifi.blue, borderRadius: BorderRadius.circular(3)),
                                  padding: EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Randevulu Vakadır'),
                                      Text(widget.planedDate.toString()),
                                    ],
                                  ),
                                )
                              : widget.respondedTimer == '1'
                                  ? Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                                      padding: EdgeInsets.all(3),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Hedef Yanıtlama Tarihi'),
                                          widget.targetRDate == ''
                                              ? Text('')
                                              : Text(
                                                  timeRecover(widget.targetRDate).toString(),
                                                  style: fixStyle(widget.respondedTimer.toString(), widget.fixTimer.toString(),
                                                      widget.targetFDate.toString(), widget.fixedDate.toString()),
                                                )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      padding: EdgeInsets.all(3),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Yanıtlama Tarihi'),
                                          widget.respondedDate == ''
                                              ? Text('')
                                              : Text(
                                                  timeRecover(widget.respondedDate).toString(),
                                                  style: fixStyle(widget.respondedTimer.toString(), widget.fixTimer.toString(),
                                                      widget.targetFDate.toString(), widget.fixedDate.toString()),
                                                ),
                                        ],
                                      ),
                                    ),
                        ],
                      ),
                      Column(children: [
                        widget.fixTimer == '1'
                            ? Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Hedef Düzeltme Tarihi'),
                                    widget.targetFDate == ''
                                        ? Text('')
                                        : Text(
                                            timeRecover(widget.targetFDate).toString(),
                                            style: fixStyle(widget.respondedTimer.toString(), widget.fixTimer.toString(),
                                                widget.targetFDate.toString(), widget.fixedDate.toString()),
                                          ),
                                  ],
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                padding: EdgeInsets.all(3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Düzeltme Tarihi'),
                                    widget.fixedDate == ''
                                        ? Text('')
                                        : Text(
                                            timeRecover(widget.fixedDate).toString(),
                                            style: fixStyle(widget.respondedTimer.toString(), widget.fixTimer.toString(),
                                                widget.targetFDate.toString(), widget.fixedDate.toString()),
                                          ),
                                  ],
                                ),
                              ),
                      ])
                    ],
                  ),
                  Divider(height: 15, color: APPColors.Main.black),
                  widget.code != ''
                      ? Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                widget.code != '' ? widget.code.toString() : '',
                                style: TextStyle(
                                  color: APPColors.Secondary.black,
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                widget.idate != '' ? widget.idate.toString() : '',
                                style: TextStyle(
                                  color: APPColors.Secondary.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  widget.statusName != ''
                      ? Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                widget.statusName != '' ? widget.statusName.toString() : '',
                                style: TextStyle(
                                  color: APPColors.Secondary.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(flex: 3, child: Text(''))
                          ],
                        )
                      : Container(),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Açıklama',
                          style: TextStyle(
                            color: APPColors.Secondary.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.description.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          widget.contactName.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          widget.locName.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          widget.locTree.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          widget.title.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          widget.cmdb.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          widget.idate.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          widget.ani.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          timeRecover(widget.targetRDate).toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
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
                        flex: 3,
                        child: Text(
                          timeRecover(widget.targetFDate).toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'HYS-48 saat ${widget.hys.toString() != '' ? {widget.hys.toString()} : ''}',
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'HDS-48 saat ${widget.hds.toString() != '' ? {widget.hds.toString()} : ''}',
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Atama Grubu',
                          style: TextStyle(
                            color: APPColors.Secondary.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.assignmentGroupName.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Atanan Kişi',
                          style: TextStyle(
                            color: APPColors.Secondary.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.assigneName.toString(),
                          style: TextStyle(color: APPColors.Secondary.black, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
