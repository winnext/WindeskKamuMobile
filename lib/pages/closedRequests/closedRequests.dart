// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/pages/closedRequests/closedRequestsDetail.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../api/api_repository.dart';
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/ListWidgets/customIssueListWidget.dart';
import '../../widgets/customInfoNotFound.dart';

class ClosedRequestListScreen extends StatefulWidget {
  static String pageName = 'listPageComplaintRequests';

  const ClosedRequestListScreen({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<ClosedRequestListScreen> createState() => _ClosedRequestListScreenState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _ClosedRequestListScreenState extends State<ClosedRequestListScreen> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.exampleListView.clear();
    exampleList.loadData(1, 'MyClosedIssuesIsCustomer');
    exampleList.initData(widget.pageController);
  }

  @override
  void dispose() {
    detailViewProvider?.dispose();
    listViewProvider?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    final detailViewProvider = Provider.of<DetailViewProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              'Kapatılmış Taleplerim',
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  dispose();
                  Navigator.of(context).popUntil(ModalRoute.withName("/"));
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  listViewProvider.exampleListView.isNotEmpty
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                          onNotification: listViewProvider.notificationController,
                          child: ListView.builder(
                              itemCount: listViewProvider.exampleListView.length,
                              itemBuilder: (BuildContext context, int i) {
                                l++;
                                if (l == 5) {
                                  l = 0;
                                }
                                ListViewModel listElements = listViewProvider.exampleListView[i];
                                final plannedDate = timeRecover(listElements.PLANNEDDATE);
                                final time = DateTime.now();
                                final String timeNow = DateFormat('yMMddhhmmss').format(time).toString();
                                if (listElements.RESPONDED_IDATE != null && listElements.TARGET_FDATE != null) {
                                  print('responsedI');

                                  print(int.parse(listElements.RESPONDED_IDATE.toString()) - int.parse(listElements.TARGET_RDATE.toString()));
                                }

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TaskListWidget(
                                          importanceLevelColor: generateColor(l),
                                          code: listElements.CODE.toString(),
                                          targetFDate: listElements.TARGET_FDATE,
                                          targetRDate: listElements.TARGET_RDATE,
                                          taskNo: i.toString(),
                                          description: listElements.DESCRIPTION.toString(),
                                          sumdesc1: listElements.SUMDESC1.toString(),
                                          statusName: listElements.STATUSNAME.toString(),
                                          space: listElements.SPACE.toString(),
                                          location: listElements.LOCATION.toString(),
                                          idate: listElements.IDATE.toString(),
                                          statusCode: listElements.STATUSCODE.toString(),
                                          planedDate: plannedDate.toString(),
                                          respondedIDate: listElements.RESPONDED_IDATE.toString(),
                                          responseTimer: listElements.response_timer.toString(),
                                          fixedTimer: listElements.fixed_timer.toString(),
                                          fixedIDate: listElements.FIXED_IDATE.toString(),
                                          timeInfoNow: timeNow,
                                          isIcon: true,
                                          onPressed: (code) {
                                            detailViewProvider.setIssueCode = code;
                                            Navigator.pushNamed(context, ClosedRequestDetail.closedRequestDetail);
                                            print('tiklandi' + code);
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
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
                          child: const Center(child: AramaSonucBos()),
                        ),
                ],
              ),
              if (listViewProvider.isDataLoading == true) ...[loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)],
            ],
          )),
    );
  }

  Widget sayfaYenile() {
    return Consumer<ListViewProvider>(builder: (context, listViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            listViewProvider.setisDataLoading = true;
            listViewProvider.exampleListView.clear();
            listViewProvider.setcurrentPage = 1;
            listViewProvider.loadData(listViewProvider.currentPage, 'OPlannedIssuesIsCustomer');
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
