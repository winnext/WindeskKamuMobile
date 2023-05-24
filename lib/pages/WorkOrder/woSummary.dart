import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/pages/WorkOrder/woList.dart';
import 'package:win_kamu/providers/workorder_detail_provider.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../utils/themes.dart';
import '../../utils/time_Utils.dart';

class WoSummary extends StatefulWidget {
  String woCode;
  String? moduleCode;
  String? targetFDate;
  String? targetRDate;
  String? fixTimer;
  String? fixedDate;
  String? respondedDate;
  String? respondedTimer;
  String? planedDate;
  String? statusCode;

  WoSummary(
      {this.fixTimer,
      this.fixedDate,
      this.respondedDate,
      this.respondedTimer,
      this.targetFDate,
      this.targetRDate,
      this.planedDate,
      required this.woCode,
      this.statusCode,
      this.moduleCode,
      super.key});

  @override
  State<WoSummary> createState() => _WoSummaryState();
}

class _WoSummaryState extends State<WoSummary> {
  bool isMym = false;
  @override
  void initState() {
    setState(() {
      isMym = mymCheck(widget.moduleCode.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: true);
    final woDetailList = woDetailViewProvider.woDetailView[0];
    final woRelatedList = woDetailViewProvider.woRelatedView[0];
    return Column(
      children: [
        isMym
            ? Expanded(
                child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      padding: EdgeInsets.all(3),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Hedef Yanıtlama Tarihi'),
                                          widget.targetRDate == ''
                                              ? Text('')
                                              : Text(
                                                  timeRecover(
                                                          widget.targetRDate)
                                                      .toString(),
                                                  style: fixStyle(
                                                      widget.respondedTimer
                                                          .toString(),
                                                      widget.fixTimer
                                                          .toString(),
                                                      widget.targetFDate
                                                          .toString(),
                                                      widget.fixedDate
                                                          .toString()),
                                                )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      padding: EdgeInsets.all(3),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Yanıtlama Tarihi'),
                                          widget.respondedDate == ''
                                              ? Text('')
                                              : Text(
                                                  timeRecover(
                                                          widget.respondedDate)
                                                      .toString(),
                                                  style: fixStyle(
                                                      widget.respondedTimer
                                                          .toString(),
                                                      widget.fixTimer
                                                          .toString(),
                                                      widget.targetFDate
                                                          .toString(),
                                                      widget.fixedDate
                                                          .toString()),
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
                                    widget.targetFDate == ''
                                        ? Text('')
                                        : Text(
                                            timeRecover(widget.targetFDate)
                                                .toString(),
                                            style: fixStyle(
                                                widget.respondedTimer
                                                    .toString(),
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
                                    widget.fixedDate == ''
                                        ? Text('')
                                        : Text(
                                            timeRecover(widget.fixedDate)
                                                .toString(),
                                            style: fixStyle(
                                                widget.respondedTimer
                                                    .toString(),
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
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: APPColors.Main.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          woDetailList.NAME.toString(),
                          style: TextStyle(
                              color: APPColors.Main.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          woDetailList.DESCRIPTION.toString(),
                          style: TextStyle(color: APPColors.Main.black),
                        ),
                      ),
                    ),
                    woDetailList.PRIORITY == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.navigation_rounded),
                                  Text(
                                    woDetailList.PRIORITY.toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    woRelatedList.BUSINESS_CODE == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.navigation_outlined),
                                  Text(
                                    woRelatedList.BUSINESS_CODE.toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    woRelatedList.BUSINESS_NAME == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.navigation_outlined),
                                  Text(
                                    woRelatedList.BUSINESS_NAME.toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    woDetailList.MODULECODE == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.apartment_outlined),
                                  Text(
                                    woDetailList.MODULECODE.toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    woDetailList.MODULENAME == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.apartment_outlined),
                                  Text(
                                    woDetailList.MODULENAME.toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    // Buraya global endpoint bilgisine göre valık bilgisi eklenecektir.
                    //ESH ve MYM kondisyonu için RESPONSIBLE düzenlenecektir.
                    woDetailList.RESPONSIBLE == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.apartment_outlined),
                                  Text(
                                    woDetailList.RESPONSIBLE.toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    woDetailList.IUSER == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.person_outline),
                                  Text(
                                    woDetailList.IUSER.toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    woDetailList.PLANNED_TIME == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  Text(
                                    convertSecToStringFormat(woDetailList
                                            .PLANNED_TIME
                                            .toString())
                                        .toString(),
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    woDetailList.PLANNED_STARTDATE == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  Text(
                                    '${woDetailList.PLANNED_STARTDATE.toString()} --> ${woDetailList.PLANNED_ENDDATE.toString()} ',
                                    style:
                                        TextStyle(color: APPColors.Main.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ]),
                ),
              ),
      ],
    );
  }
}

mymCheck(woCode) {
  if (woCode[0] == 'M') {
    return true;
  } else {
    return false;
  }
}
