import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/WorkOrder/woOperation.dart';
import 'package:win_kamu/pages/WorkOrder/woSummary.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';

import '../../models/detail_view.model.dart';
import '../../models/issue_summary.modal.dart';
import '../../providers/workorder_detail_provider.dart';
import '../../providers/main_page_view_provider.dart';
import '../../providers/workorder_detail_provider.dart';
import '../../utils/themes.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';

class WoDetail extends StatefulWidget {
  String woCode;
  String? moduleCode;
  WoDetail({required this.woCode, this.moduleCode, super.key});

  @override
  State<WoDetail> createState() => _WoDetailState();
}

class _WoDetailState extends State<WoDetail> {
  String dateNow = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());

  

  start() {
    final mainPageViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: false);
    final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: false);
    detailViewProvider.exampleListView.clear();
    detailViewProvider.issueSummary.clear();

    woDetailViewProvider.loadWoDetail(widget.woCode, mainPageViewProvider.kadi);
    woDetailViewProvider.woGetRelatedSpace(
        widget.woCode, mainPageViewProvider.kadi);

    widget.moduleCode.toString() == ''
        ? null
        : detailViewProvider.loadData(
            widget.moduleCode.toString(), mainPageViewProvider.kadi);
    widget.moduleCode.toString() == ''
        ? null
        : detailViewProvider.loadIssueSummary(
            widget.moduleCode.toString(), mainPageViewProvider.kadi);
  }

  @override
  void initState() {
    start();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;

    final woDetailViewProvider = Provider.of<WoDetailViewProvider>(context,listen: true);
    final detailViewProvider = Provider.of<DetailViewProvider>(context,listen: false);
    final mainPageViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);

    
    var woDetailList = woDetailViewProvider.woDetailView[0];
    var woRelatedList = woDetailViewProvider.woRelatedView[0];
  print('İş Emri Durumu : '+woDetailList.STATUS.toString());

  print(woDetailViewProvider.secilenSure);

    return Sizer ( builder: (context, Orientation, deviceType) {
      return Scaffold(
      appBar: AppBar(
        backgroundColor: APPColors.Main.white,
        title: Text(
          widget.woCode,
          style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              //   Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  detailViewProvider.isDataExist
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                            child: ListView.builder(
                                itemCount:
                                    detailViewProvider?.exampleListView.length,
                                itemBuilder: (BuildContext context, int i) {
                                  l++;
                                  if (l == 5) {
                                    l = 0;
                                  }
                                  String formattedDate = "";
                                  DetailViewModel? detailElements =
                                      detailViewProvider?.exampleListView[0];
                                  IssueSummaryModal? issueSummary =
                                      detailViewProvider?.issueSummary[0];
        
                                  final TARGET_FDATE = detailElements
                                              ?.TARGET_FDATE !=
                                          null
                                      ? timeRecover(detailElements?.TARGET_FDATE)
                                      : '';
                                  final TARGET_RDATE = detailElements
                                              ?.TARGET_RDATE !=
                                          null
                                      ? timeRecover(detailElements?.TARGET_RDATE)
                                      : '';
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: APPColors.NewNotifi.blue,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          padding: EdgeInsets.all(3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('asd'),
                                              Text(dateNow.toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 0.0),
                                            child: Column(
                                              children: [
                                                WoSummary(
                                                  woCode:
                                                      woDetailViewProvider.woCode,
                                                  targetFDate: detailElements
                                                              ?.TARGET_FDATE ==
                                                          null
                                                      ? ''
                                                      : detailElements
                                                          ?.TARGET_FDATE
                                                          .toString(),
                                                  targetRDate: detailElements
                                                              ?.TARGET_RDATE ==
                                                          null
                                                      ? ''
                                                      : detailElements
                                                          ?.TARGET_RDATE
                                                          .toString(),
                                                  fixTimer: issueSummary
                                                              ?.FIX_TIMER ==
                                                          null
                                                      ? ''
                                                      : issueSummary?.FIX_TIMER
                                                          .toString(),
                                                  fixedDate: issueSummary
                                                              ?.FIXED_DATE ==
                                                          null
                                                      ? ''
                                                      : issueSummary?.FIXED_DATE
                                                          .toString(),
                                                  respondedDate: issueSummary
                                                              ?.RESPONDED_DATE ==
                                                          null
                                                      ? ''
                                                      : issueSummary
                                                          ?.RESPONDED_DATE
                                                          .toString(),
                                                  respondedTimer: issueSummary
                                                              ?.RESPONDED_TIMER ==
                                                          null
                                                      ? ''
                                                      : issueSummary
                                                          ?.RESPONDED_TIMER
                                                          .toString(),
                                                  planedDate: issueSummary
                                                              ?.PLANNED_DATE ==
                                                          null
                                                      ? ''
                                                      : issueSummary?.PLANNED_DATE
                                                          .toString(),
                                                  statusCode: issueSummary
                                                              ?.STATUS_CODE ==
                                                          null
                                                      ? ''
                                                      : issueSummary?.STATUS_CODE
                                                          .toString(),
                                                  moduleCode: widget.moduleCode
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        )
                      : Container(
                          child: WoSummary(
                            woCode: widget.woCode,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /////////////////////////////////
                               ///Başlat kısmı başlangıç //////////
                               ////////////////////////////////
                           woDetailList.STATUS == 'Open'   ?   Container(
                          
                                 width: 30.w,
                                 height: 6.h,
                                 child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: APPColors.Login.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                      
                          ),
                        ),
                        onPressed: () {
                          // iş emri başlat
                          print('Başlanacak iş emri : '+woDetailList.CODE.toString());
                          woDetailViewProvider.woActualDateActions('start', woDetailList.CODE);
                            //woDetailViewProvider.loadWoDetail(widget.woCode, mainPageViewProvider.kadi);
                          Timer(Duration(seconds: 1), () {
                              start();
                          });

                        },
                        child: Text('Başlat'),
                                          ),
                               ) :   Container(
                          
                                 width: 30.w,
                                 height: 6.h,
                                 child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                      
                          ),
                        ),
                        onPressed: () {
                          
                        },
                        child: Text('Başlat'),
                                          ),
                               ),
                              /////////////////////////////////
                               ///Başlat kısmı bitiş //////////
                               ////////////////////////////////
                               ///
                               /// /////////////////////////////////
                               ///Bitir kısmı başlangıç //////////
                               ////////////////////////////////
                           woDetailList.STATUS == 'WIP' ||   woDetailList.STATUS == 'Pending' ? 
                            Container(
                          
                                 width: 30.w,
                                 height: 6.h,
                                 child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                      
                          ),
                        ),
                        onPressed: () {
                           print('Bitecek iş emri : '+woDetailList.CODE.toString());
                          woDetailViewProvider.woActualDateActions('end', woDetailList.CODE);
                              //woDetailViewProvider.loadWoDetail(widget.woCode, mainPageViewProvider.kadi);

                           Timer(Duration(seconds: 1), () {
                              start();
                          });
                        },
                        child: Text('Bitir'),
                                          ),
                               ) : 
                                Container(
                          
                                 width: 30.w,
                                 height: 6.h,
                                 child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                      
                          ),
                        ),
                        onPressed: () {
                          
                        },
                        child: Text('Bitir'),
                                          ),
                               ),

                            ],
                          ) ,
                        ),
                         /////////////////////////////////
                               ///Bitir kısmı bitiş //////////
                               ////////////////////////////////
                        Text(''),
                         Container(
                          
                                 width: 15.w,
                                 height: 6.h,
                                 child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: APPColors.Login.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                      
                          ),
                        ),
                        onPressed: () {
                          
                        },
                        child: Icon(Icons.add_a_photo),
                                          ),
                               ),
                               woDetailList.STATUS == 'WIP' ||   woDetailList.STATUS == 'Pending' ? 
                               WoOperation(woCode: widget.woCode,) : Text('')
                        
                ],
              ),
            ],
          ),
        ),
      ]),
    );

    } 
    );
  }
}
