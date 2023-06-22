// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/models/issue_summary.modal.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/pages/openRequests/routeRequests.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:win_kamu/widgets/commons.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/widgets/listWidgets/customIssueDetailWidget.dart';
import '../../api/api_repository.dart';
import '../../l10n/locale_keys.g.dart';
import '../../models/detail_view.model.dart';
import '../../utils/global_utils.dart';
import '../../utils/isEmpty_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customIssueListWidget.dart';
import '../../widgets/modalWidgets/issueActionModal.dart';
import '../homePage.dart';

class IssueDetail extends StatefulWidget {
  static String issueDetail = 'IssueDetail';

  const IssueDetail({Key? key}) : super(key: key);
  @override
  State<IssueDetail> createState() => _IssueDetailState();
}

final apirepository = APIRepository();

DetailViewProvider? detailViewProvider;
MainPageViewProvider? mainPageViewProvider;

class _IssueDetailState extends State<IssueDetail> with AutomaticKeepAliveClientMixin<IssueDetail> {
  String dateNow = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());

  changeTime() {
    setState(() {
      dateNow = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());
    });
  }

  @override
  bool get wantKeepAlive => true;
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      changeTime();
    });
    final mainPageViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: false);
    detailViewProvider.exampleListView.clear();
    detailViewProvider.issueSummary.clear();
    detailViewProvider.loadData(
        detailViewProvider.issueCode, mainPageViewProvider.kadi);
    detailViewProvider.loadIssueSummary(
        detailViewProvider.issueCode, mainPageViewProvider.kadi);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement exa

    detailViewProvider?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int l = -1;
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: true);
    final mainPageViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                !detailViewProvider.isDataExist
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
                                          Text(mainPageViewProvider.kadi),
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
                                            DetailListWidget(
                                              ani: isEmptyorUndefined(
                                                  detailElements!.ANI
                                                      .toString()),
                                              description: isEmptyorUndefined(
                                                  detailElements!.DESCRIPTION
                                                      .toString()),
                                              targetFDate: isEmptyorUndefined(
                                                  detailElements!.TARGET_FDATE
                                                      .toString()),
                                              targetRDate: isEmptyorUndefined(
                                                  detailElements!.TARGET_RDATE
                                                      .toString()),
                                              statusName: isEmptyorUndefined(
                                                  detailElements!.STATUSNAME
                                                      .toString()),
                                              assigneName: isEmptyorUndefined(
                                                  detailElements!.ASSIGNEENAME
                                                      .toString()),
                                              assignmentGroup:
                                                  isEmptyorUndefined(
                                                      detailElements!
                                                          .ASSIGNMENTGROUP
                                                          .toString()),
                                              assignmentGroupName:
                                                  isEmptyorUndefined(
                                                      detailElements!
                                                          .ASSIGNMENTGROUPNAME
                                                          .toString()),
                                              cat1: isEmptyorUndefined(
                                                  detailElements!.CAT1
                                                      .toString()),
                                              cmdb: isEmptyorUndefined(
                                                  detailElements!.CMDB
                                                      .toString()),
                                              code: isEmptyorUndefined(
                                                  detailElements!.CODE
                                                      .toString()),
                                              contactCode: isEmptyorUndefined(
                                                  detailElements!.CONTACTCODE
                                                      .toString()),
                                              contactName: isEmptyorUndefined(
                                                  detailElements!.CONTACTNAME
                                                      .toString()),
                                              idate: isEmptyorUndefined(
                                                  detailElements!.IDATE
                                                      .toString()),
                                              locName: isEmptyorUndefined(
                                                  detailElements!.LOCNAME
                                                      .toString()),
                                              locTree: isEmptyorUndefined(
                                                  detailElements!.LOCTREE
                                                      .toString()),
                                              locTree2: isEmptyorUndefined(
                                                  detailElements!.LOCTREE2
                                                      .toString()),
                                              sumdesc1: isEmptyorUndefined(
                                                  detailElements!.SUMDESC1
                                                      .toString()),
                                              taskNo: isEmptyorUndefined(
                                                  detailElements!.CODE
                                                      .toString()),
                                              title: isEmptyorUndefined(
                                                  detailElements!.TITLE
                                                      .toString()),
                                              onPressed: (code) {},
                                              fixTimer: isEmptyorUndefined(
                                                  issueSummary!.FIX_TIMER
                                                      .toString()),
                                              fixedDate: isEmptyorUndefined(
                                                  issueSummary!.FIXED_DATE
                                                      .toString()),
                                              respondedDate: isEmptyorUndefined(
                                                  issueSummary!.RESPONDED_DATE
                                                      .toString()),
                                              respondedTimer:
                                                  isEmptyorUndefined(
                                                      issueSummary
                                                          .RESPONDED_TIMER
                                                          .toString()),
                                              xusercode: mainPageViewProvider
                                                  .kadi
                                                  .toString(),
                                              // extraTitle:
                                              //     detailElements.STATUSCODE.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ))
                    : Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.5),
                        child: const Center(child: AramaSonucBos()),
                      ),
              ],
            ),
            if (detailViewProvider.isDataLoading == true) ...[
              loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)
            ],
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final detailViewProvider =
                Provider.of<DetailViewProvider>(context, listen: false);
            final mainPageViewProvider =
                Provider.of<MainPageViewProvider>(context, listen: false);
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => IssueActionButton(
                    code: detailViewProvider.issueCode,
                    xusercode: mainPageViewProvider.kadi));
          },
          backgroundColor: APPColors.Modal.red,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }

  Widget sayfaYenile(username) {
    return Consumer<DetailViewProvider>(
        builder: (context, DetailViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            detailViewProvider?.setisDataLoading = true;
            detailViewProvider?.exampleListView.clear();
            detailViewProvider?.loadData(
                detailViewProvider?.issueCode, username);
          });
        },
        child: const Padding(
          padding: EdgeInsets.all(height_18),
          child: Icon(Icons.refresh),
        ),
      );
    });
  }
}
