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
import 'package:win_kamu/widgets/listWidgets/customOpenIssueDetail.dart';
import '../../api/api_repository.dart';
import '../../l10n/locale_keys.g.dart';
import '../../models/detail_view.model.dart';
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customOpenIssueWidget.dart';
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

class _IssueDetailState extends State<IssueDetail> {
  String dateNow = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());

  changeTime() {
    setState(() {
      dateNow = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());
    });
  }

  @override
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
    // TODO: implement dispose

    detailViewProvider?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int l = -1;
    final detailViewProvider = Provider.of<DetailViewProvider>(context);
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
                          itemCount: detailViewProvider?.exampleListView.length,
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

                            final TARGET_FDATE =
                                timeRecover(detailElements?.TARGET_FDATE);
                            final TARGET_RDATE =
                                timeRecover(detailElements?.TARGET_RDATE);

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: APPColors.NewNotifi.blue,
                                        borderRadius: BorderRadius.circular(3)),
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
                                            ani: detailElements?.ANI,
                                            description:
                                                detailElements?.DESCRIPTION,
                                            targetFDate: detailElements
                                                ?.TARGET_FDATE
                                                .toString(),
                                            targetRDate: detailElements
                                                ?.TARGET_RDATE
                                                .toString(),
                                            statusName:
                                                detailElements?.STATUSNAME,
                                            assigneName:
                                                detailElements?.ASSIGNEENAME,
                                            assignmentGroup:
                                                detailElements?.ASSIGNMENTGROUP,
                                            assignmentGroupName: detailElements
                                                ?.ASSIGNMENTGROUPNAME,
                                            cat1: detailElements?.CAT1,
                                            cmdb: detailElements?.CMDB,
                                            code: detailElements?.CODE,
                                            contactCode:
                                                detailElements?.CONTACTCODE,
                                            contactName:
                                                detailElements?.CONTACTNAME,
                                            idate: detailElements?.IDATE,
                                            locName: detailElements?.LOCNAME,
                                            locTree: detailElements?.LOCTREE,
                                            locTree2: detailElements?.LOCTREE2,
                                            sumdesc1: detailElements?.SUMDESC1,
                                            taskNo:
                                                detailElements?.CODE.toString(),
                                            title: detailElements?.TITLE,
                                            onPressed: (code) {
                                              print('tiklandi' + code);
                                            },
                                            fixTimer: issueSummary?.FIX_TIMER,
                                            fixedDate: issueSummary?.FIXED_DATE,
                                            respondedDate:
                                                issueSummary?.RESPONDED_DATE,
                                            respondedTimer:
                                                issueSummary?.RESPONDED_TIMER,
                                            xusercode: 'sgnm1040',
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
      )),
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
