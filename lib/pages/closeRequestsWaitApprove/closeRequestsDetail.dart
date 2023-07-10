// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/routeRequests.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/widgets/listWidgets/customIssueDetailWidget.dart';
import '../../api/api_repository.dart';
import '../../models/detail_view.model.dart';
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';

class CloseRequestDetail extends StatefulWidget {
  static String closeRequestDetail = 'CloseRequestDetail';

  const CloseRequestDetail({Key? key}) : super(key: key);
  @override
  State<CloseRequestDetail> createState() => _CloseRequestDetailState();
}

final apirepository = APIRepository();

DetailViewProvider? detailViewProvider;
MainPageViewProvider? mainPageViewProvider;

class _CloseRequestDetailState extends State<CloseRequestDetail> {
  @override
  void initState() {
    super.initState();
    final mainPageViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);
    final detailViewProvider = Provider.of<DetailViewProvider>(context, listen: false);
    detailViewProvider.exampleListView.clear();
    detailViewProvider.loadData(detailViewProvider.issueCode, mainPageViewProvider.kadi);
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
    final mainPageViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              'Kapanma Onayı Bekleyenler Detay',
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(CloseRequestAwaitApproval.closeRequest);
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
                              itemCount: detailViewProvider.exampleListView.length,
                              itemBuilder: (BuildContext context, int i) {
                                l++;
                                if (l == 5) {
                                  l = 0;
                                }
                                DetailViewModel? detailElements = detailViewProvider.exampleListView[0];

                                final targetFdate = timeRecover(detailElements.TARGET_FDATE);
                                final targetRdate = timeRecover(detailElements.TARGET_RDATE);

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(mainPageViewProvider.kadi),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                                      child: DetailListWidget(
                                          ani: detailElements.ANI,
                                          description: detailElements.DESCRIPTION,
                                          targetFDate: targetFdate,
                                          targetRDate: targetRdate,
                                          statusName: detailElements.STATUSNAME,
                                          assigneName: detailElements.ASSIGNEENAME,
                                          assignmentGroup: detailElements.ASSIGNMENTGROUP,
                                          assignmentGroupName: detailElements.ASSIGNMENTGROUPNAME,
                                          cat1: detailElements.CAT1,
                                          cmdb: detailElements.CMDB,
                                          code: detailElements.CODE,
                                          contactCode: detailElements.CONTACTCODE,
                                          contactName: detailElements.CONTACTNAME,
                                          idate: detailElements.IDATE,
                                          locName: detailElements.LOCNAME,
                                          locTree: detailElements.LOCTREE,
                                          locTree2: detailElements.LOCTREE2,
                                          sumdesc1: detailElements.SUMDESC1,
                                          taskNo: detailElements.CODE.toString(),
                                          title: detailElements.TITLE,
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
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
                          child: const Center(child: AramaSonucBos()),
                        ),
                ],
              ),
              if (detailViewProvider.isDataLoading == true) ...[loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)],
            ],
          )),
    );
  }

  Widget sayfaYenile(username) {
    return Consumer<DetailViewProvider>(builder: (context, DetailViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            detailViewProvider?.setisDataLoading = true;
            detailViewProvider?.exampleListView.clear();
            detailViewProvider?.loadData(detailViewProvider?.issueCode, username);
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
