// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/pages/WorkOrder/woDetail.dart';
import 'package:win_kamu/pages/WorkOrder/woTracingList.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/workorder_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../api/api_repository.dart';
import '../../models/woListView.model.dart';
import '../../providers/main_page_view_provider.dart';
import '../../providers/workorder_detail_provider.dart';
import '../../utils/global_utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/listWidgets/customWoListWidget.dart';
import '../../widgets/modalWidgets/woFilterBox.dart';
import '../../widgets/modalWidgets/workOrderFilterModal.dart';

class WoList extends StatefulWidget {
  static String woList = 'WoList';

  const WoList({Key? key, required this.moduleCode, required this.moduleName, PageController? pageController}) : super(key: key);
  final String moduleCode;
  final String moduleName;
  @override
  State<WoList> createState() => _WoListState();
}

final apirepository = APIRepository();

WorkOrderProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _WoListState extends State<WoList> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<WorkOrderProvider>(context, listen: false);
    exampleList.woListView.clear();
    exampleList.getListWorkOrders(1, widget.moduleCode);
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
    final listViewProvider = Provider.of<WorkOrderProvider>(context);
    final detailViewProvider = Provider.of<WoDetailViewProvider>(context);
    int index = listViewProvider.currentPage;
    final exampleList = Provider.of<WorkOrderProvider>(context);
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WoTracingList()));
                  //   Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            actions: [
              IconButton(
                  icon: Icon(Icons.tune, color: APPColors.Main.black),
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent, context: context, builder: (context) => WorkOrderFilter(moduleCode: widget.moduleCode));
                  }),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  WoFilterBox(
                    moduleCode: widget.moduleCode,
                  ),
                  listViewProvider.woListView.isNotEmpty
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                          onNotification: listViewProvider.notificationController,
                          child: ListView.builder(
                              itemCount: listViewProvider.woListView.length,
                              itemBuilder: (BuildContext context, int i) {
                                l++;
                                if (l == 5) {
                                  l = 0;
                                }
                                String formattedDate = "";
                                WoListViewModel listElements = listViewProvider.woListView[i];
                                final moduleCode = listElements.MODULECODE == null ? '' : listElements.MODULECODE;
                                final time = DateTime.now();
                                final String timeNow = DateFormat('yMMddhhmmss').format(time).toString();
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: WoListWidget(
                                          importanceLevelColor: generateColor(l),
                                          code: listElements.CODE.toString(),
                                          statusName: listElements.STATUSNAME.toString(),
                                          id: listElements.ID.toString(),
                                          service: listElements.SERVICE.toString(),
                                          serviceName: listElements.SERVICE_NAME.toString(),
                                          name: listElements.NAME.toString(),
                                          plannedEndDate: listElements.PLANNED_ENDDATE.toString(),
                                          moduleLocation: listElements.MODULELOCATION,
                                          responsible: listElements.RESPONSIBLE.toString(),
                                          isIcon: true,
                                          onPressed: (code) {
                                            detailViewProvider.setwoCode = '';
                                            print('tiklandi' + code);
                                            detailViewProvider.setwoCode = code;
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => WoDetail(
                                                  moduleCode: moduleCode,
                                                  woCode: listElements.CODE.toString(),
                                                ),
                                              ),
                                            );
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
    return Consumer<WorkOrderProvider>(builder: (context, listViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            listViewProvider.setisDataLoading = true;
            listViewProvider.woListView.clear();
            listViewProvider.setcurrentPage = 1;
            listViewProvider.getListWorkOrders(listViewProvider.currentPage, 'workorder');
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
