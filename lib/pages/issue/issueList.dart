// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/issue/issueSummary.dart';
import 'package:win_kamu/pages/issue/issueTracingList.dart';
import 'package:win_kamu/pages/issue/routeIssue.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:win_kamu/widgets/commons.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/widgets/modalWidgets/filterBox.dart';
import '../../api/api_repository.dart';
import '../../l10n/locale_keys.g.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customIssueListWidget.dart';
import '../../widgets/modalWidgets/filterModal.dart';
import '../../widgets/modalWidgets/issueActionModal.dart';
import '../homePage.dart';
import 'issueDetail.dart';

class IssueList extends StatefulWidget {
  static String issueList = 'IssueList';

  const IssueList(
      {Key? key, required this.moduleCode, required this.moduleName})
      : super(key: key);
  final String moduleCode;
  final String moduleName;
  @override
  State<IssueList> createState() => _IssueListState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _IssueListState extends State<IssueList> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.exampleListView.clear();
    exampleList.loadData(1, widget.moduleCode);
    exampleList.setmoduleCode = widget.moduleCode;
    exampleList.setmoduleName = widget.moduleName;
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
    int index = listViewProvider.currentPage;
    final exampleList = Provider.of<ListViewProvider>(context);
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);
    final ISSUECODE = '';

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              widget.moduleName,
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IssueTracingList(
                              pageController:
                                  mainViewProvide.pageController!)));
                  //   Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            actions: [
              IconButton(
                  icon: Icon(Icons.tune, color: APPColors.Main.black),
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) =>
                            IssueFilterModal(moduleCode: widget.moduleCode));
                  }),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  FilterBox(
                    moduleCode: widget.moduleCode,
                  ),
                  listViewProvider.exampleListView.isNotEmpty
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                          onNotification:
                              listViewProvider.notificationController,
                          child: ListView.builder(
                              itemCount:
                                  listViewProvider.exampleListView.length,
                              itemBuilder: (BuildContext context, int i) {
                                l++;
                                if (l == 5) {
                                  l = 0;
                                }
                                String formattedDate = "";
                                ListViewModel listElements =
                                    listViewProvider.exampleListView[i];
                                final TARGET_FDATE =
                                    timeRecover(listElements.TARGET_FDATE);
                                final TARGET_RDATE =
                                    timeRecover(listElements.TARGET_RDATE);
                                final ISSUECODE = listElements.CODE.toString();
                                final time = DateTime.now();
                                final String timeNow = DateFormat('yMMddhhmmss')
                                    .format(time)
                                    .toString();
                                if (listElements.RESPONDED_IDATE != null &&
                                    listElements.TARGET_FDATE != null) {
                                  print(int.parse(listElements.RESPONDED_IDATE
                                          .toString()) -
                                      int.parse(listElements.TARGET_RDATE
                                          .toString()));
                                }

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TaskListWidget(
                                          importanceLevelColor:
                                              generateColor(l),
                                          code: listElements.CODE.toString(),
                                          targetFDate:
                                              listElements.TARGET_FDATE,
                                          targetRDate:
                                              listElements.TARGET_RDATE,
                                          taskNo: i.toString(),
                                          description: listElements.DESCRIPTION
                                              .toString(),
                                          sumdesc1:
                                              listElements.SUMDESC1.toString(),
                                          statusName: listElements.STATUSNAME
                                              .toString(),
                                          space: listElements.SPACE.toString(),
                                          location:
                                              listElements.LOCATION.toString(),
                                          idate: listElements.IDATE.toString(),
                                          statusCode: listElements.STATUSCODE
                                              .toString(),
                                          planedDate: listElements.PLANNEDDATE
                                              .toString(),
                                          respondedIDate: listElements
                                              .RESPONDED_IDATE
                                              .toString(),
                                          responseTimer: listElements
                                              .response_timer
                                              .toString(),
                                          fixedTimer: listElements.fixed_timer
                                              .toString(),
                                          fixedIDate: listElements.FIXED_IDATE
                                              .toString(),
                                          timeInfoNow: timeNow,
                                          isIcon: true,
                                          onPressed: (code) {
                                            detailViewProvider.setIssueCode =
                                                '';
                                            print('tiklandi' + code);
                                            detailViewProvider.setIssueCode =
                                                code;
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const IssueSummary(),
                                              ),
                                            );
                                            // Navigator.pushNamed(context,
                                            //     IssueDetail.issueDetail);
                                          },
                                          onPressedLong: () {
                                            print('pressed');
                                          }
                                          // extraTitle:
                                          //     listElements.STATUSCODE.toString(),
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
              if (listViewProvider.isDataLoading == true) ...[
                loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)
              ],
            ],
          )),
    );
  }

  Widget sayfaYenile() {
    return Consumer<ListViewProvider>(
        builder: (context, listViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            listViewProvider.setisDataLoading = true;
            listViewProvider.exampleListView.clear();
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
