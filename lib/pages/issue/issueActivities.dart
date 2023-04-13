// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/models/issue_activities.modal.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:win_kamu/widgets/commons.dart';
import 'package:provider/provider.dart';
import '../../api/api_repository.dart';
import '../../l10n/locale_keys.g.dart';
import '../../models/tracing_view.model.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customOpenIssueWidget.dart';
import '../homePage.dart';
import 'issueDetail.dart';
import 'issueList.dart';

class IssueActivities extends StatefulWidget {
  static String activitiesList = 'ActivitiesList';

  const IssueActivities({Key? key}) : super(key: key);
  @override
  State<IssueActivities> createState() => _IssueActivitiesState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _IssueActivitiesState extends State<IssueActivities> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: false);
    exampleList.issueActivitiesView.clear();
    exampleList.getIssueActivities('sgnm1027', detailViewProvider.issueCode);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listViewProvider?.pageController?.dispose();
    detailViewProvider?.dispose();
    listViewProvider?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    final detailViewProvider = Provider.of<DetailViewProvider>(context);
    final crudProvider = Provider.of<CrudViewProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            listViewProvider.issueActivitiesView.length > 0
                ? Expanded(
                    child: NotificationListener<ScrollNotification>(
                    onNotification: listViewProvider.notificationController,
                    child: ListView.builder(
                        itemCount:
                            listViewProvider.issueActivitiesView.length,
                        itemBuilder: (BuildContext context, int i) {
                          l++;
                          if (l == 5) {
                            l = 0;
                          }
                          IssueActivitiesModal listElements =
                              listViewProvider.issueActivitiesView[i];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20,20,20,0),
                            child: Container(
                              decoration:
                                  BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(listElements.NAME.toString()),
                                      Text(listElements.IDATE.toString()),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(''),
                                        Text(listElements.IUSERNAME.toString()),
                                      ],
                                    ),
                                  ),
                                  Divider(height: 10, color: APPColors.Main.grey, thickness: 5.0,)
                                ],
                              ),
                            ),
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
        if (listViewProvider.isDataLoading == true) ...[
          loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)
        ],
      ],
    ));
  }

  Widget sayfaYenile() {
    return Consumer<ListViewProvider>(
        builder: (context, listViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            listViewProvider.setisDataLoading = true;
            listViewProvider.issueActivitiesView.clear();
            listViewProvider.setcurrentPage = 1;
            listViewProvider.loadData(listViewProvider.currentPage, 'issue');
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
