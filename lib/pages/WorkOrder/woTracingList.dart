// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:win_kamu/pages/WorkOrder/woList.dart';
import 'package:win_kamu/providers/workorder_provider.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../api/api_repository.dart';
import '../../models/tracing_view.model.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customIssueListWidget.dart';
import '../homePage.dart';

class WoTracingList extends StatefulWidget {
  static String tracingList = 'TracingList';

  const WoTracingList({Key? key})
      : super(key: key);
  @override
  State<WoTracingList> createState() => _WoTracingListState();
}

final apirepository = APIRepository();

WorkOrderProvider? workOrderProvider;
DetailViewProvider? detailViewProvider;

class _WoTracingListState extends State<WoTracingList> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<WorkOrderProvider>(context, listen: false);
    final mainViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    exampleList.tracingListView.clear();
    exampleList.getTracingListWithCount(mainViewProvider.kadi, 'workorder');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    workOrderProvider?.pageController?.dispose();
    detailViewProvider?.dispose();
    workOrderProvider?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final workOrderProvider = Provider.of<WorkOrderProvider>(context);
    final detailViewProvider = Provider.of<DetailViewProvider>(context);
    final crudProvider = Provider.of<CrudViewProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              'İş Emri Listesi',
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()));                  //   Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  workOrderProvider.tracingListView.isNotEmpty
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                          onNotification:
                              workOrderProvider.notificationController,
                          child: ListView.builder(
                              itemCount:
                                  workOrderProvider.tracingListView.length,
                              itemBuilder: (BuildContext context, int i) {
                                l++;
                                if (l == 5) {
                                  l = 0;
                                }
                                TracingViewModal listElements =
                                    workOrderProvider.tracingListView[i];
                                return GestureDetector(
                                  onTap: () {
                                    final mainViewProvider =
                                        Provider.of<MainPageViewProvider>(
                                            context,
                                            listen: false);
                                    listElements
                                          .count
                                          .toString() ==
                                      '0' ? null : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WoList(
                                            pageController: mainViewProvider
                                                .pageController!,
                                            moduleCode:
                                                listElements.code.toString(),
                                            moduleName:
                                                listElements.name.toString(),
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 5, 20, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: APPColors.Main.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: APPColors.Main.grey,
                                            blurRadius: 1,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                      listElements.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: listElements
                                                                      .count
                                                                      .toString() ==
                                                                  '0'
                                                              ? APPColors
                                                                  .Main.grey
                                                              : APPColors
                                                                  .Main.black),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      listElements.count
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color: APPColors
                                                              .TracingNumber
                                                              .blue),
                                                    ),
                                                  )
                                                ],
                                              )))
                                        ],
                                      ),
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
              if (workOrderProvider.isDataLoading == true) ...[
                loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)
              ],
            ],
          )),
    );
  }

  Widget sayfaYenile() {
    return Consumer<WorkOrderProvider>(
        builder: (context, WorkOrderProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            // WorkOrderProvider.setisDataLoading = true;
            // WorkOrderProvider.tracingListView.clear();
            // WorkOrderProvider.setcurrentPage = 1;
            // WorkOrderProvider.loadData(WorkOrderProvider.currentPage, 'workorder');
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
