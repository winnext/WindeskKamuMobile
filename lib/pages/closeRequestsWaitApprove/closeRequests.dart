// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customOpenIssueWidget.dart';
import '../homePage.dart';
import 'closeRequestsDetail.dart';

class CloseRequestListScreen extends StatefulWidget {
  static String pageName = 'listPageCloseRequests';

  const CloseRequestListScreen({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  State<CloseRequestListScreen> createState() => _CloseRequestListScreenState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _CloseRequestListScreenState extends State<CloseRequestListScreen> {
  bool isDone = false;
  bool _isNotDone = false;
  bool _flag = true;

  Color primaryColor = APPColors.Modal.blue;
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.exampleListView.clear();
    exampleList.loadData(1, 'PendingIssuesIsCustomer');
    exampleList.initData(widget.pageController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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

    print('isnotdone' + _isNotDone.toString());
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              'Kapatma Onayı Bekleyenler',
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/mainPage');
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  !listViewProvider.isDataExist
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
                                  final time = DateTime.now();
                                  final String timeNow =
                                      DateFormat('yMMddhhmmss')
                                          .format(time)
                                          .toString();
                                  if (listElements.RESPONDED_IDATE != null &&
                                      listElements.TARGET_FDATE != null) {
                                    print('responsedI');

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
                                            description: listElements
                                                .DESCRIPTION
                                                .toString(),
                                            sumdesc1: listElements.SUMDESC1
                                                .toString(),
                                            statusName: listElements.STATUSNAME
                                                .toString(),
                                            space:
                                                listElements.SPACE.toString(),
                                            location: listElements.LOCATION
                                                .toString(),
                                            idate:
                                                listElements.IDATE.toString(),
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
                                                  code;
                                              Navigator.pushNamed(
                                                  context,
                                                  CloseRequestDetail
                                                      .closeRequestDetail);
                                              print('tiklandi' + code);
                                            },
                                            onPressedLong: () {
                                              return showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 200,
                                                    color: APPColors.Modal.blue,
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          ElevatedButton(
                                                            child: const Text(
                                                                'Talep Yerine Getirildi'),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                          ),
                                                          ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor: _isNotDone
                                                                      ? Colors
                                                                          .amber
                                                                      : Colors
                                                                          .black),
                                                              child: const Text(
                                                                  'Talep Yerine Getirilmedi'),
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      _isNotDone =
                                                                          !_isNotDone)

                                                              // Navigator.pop(
                                                              //     context),
                                                              ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                            // extraTitle:
                                            //     listElements.STATUSCODE.toString(),
                                            ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        )
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
            listViewProvider.loadData(
                listViewProvider.currentPage, 'PendingIssuesIsCustomer');
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
