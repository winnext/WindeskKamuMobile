// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

class PlannedRequestDetail extends StatefulWidget {
  static String plannedRequestDetail = 'PlannedRequestDetail';

  const PlannedRequestDetail({Key? key}) : super(key: key);
  @override
  State<PlannedRequestDetail> createState() => _PlannedRequestDetailState();
}

final apirepository = APIRepository();

DetailViewProvider? detailViewProvider;
MainPageViewProvider? mainPageViewProvider;

class _PlannedRequestDetailState extends State<PlannedRequestDetail> {
  @override
  void initState() {
    super.initState();
    final mainPageViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: false);
    detailViewProvider.exampleListView.clear();
    detailViewProvider.loadData(
        detailViewProvider.issueCode, mainPageViewProvider.kadi);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final detailViewProvider = Provider.of<DetailViewProvider>(context);
    final mainPageViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              'Randevulu Taleplerim Detay',
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OpenRequests.openRequest);
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
          ),
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

                                final TARGET_FDATE =
                                    timeRecover(detailElements?.TARGET_FDATE);
                                final TARGET_RDATE =
                                    timeRecover(detailElements?.TARGET_RDATE);

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(mainPageViewProvider.kadi),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 20.0, 20.0, 0.0),
                                      child: DetailListWidget(
                                          ani: detailElements?.ANI,
                                          description:
                                              detailElements?.DESCRIPTION,
                                          targetFDate: TARGET_FDATE,
                                          targetRDate: TARGET_RDATE,
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
                                          }
                                          // extraTitle:
                                          //     detailElements.STATUSCODE.toString(),
                                          ),
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
