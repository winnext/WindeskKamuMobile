// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/page_titles.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/widgets/appbar/custom_main_appbar.dart';
import '../../api/api_repository.dart';
import '../../models/tracing_view.model.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../homePage.dart';
import 'issueList.dart';

class IssueTracingList extends StatefulWidget {
  static String tracingList = 'TracingList';

  const IssueTracingList({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<IssueTracingList> createState() => _IssueTracingListState();
}

final apirepository = APIRepository();
ListViewProvider? listViewProvider;

class _IssueTracingListState extends State<IssueTracingList> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.tracingListView.clear();
    exampleList.getTracingListWithCount('sgnm1040', 'issue');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listViewProvider?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: CustomMainAppbar(
            title: PageTitles.entityListTitle,
            returnBack: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                  //   Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  listViewProvider.tracingListView.isNotEmpty
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                          onNotification: listViewProvider.notificationController,
                          child: ListView.builder(
                              itemCount: listViewProvider.tracingListView.length,
                              itemBuilder: (BuildContext context, int i) {
                                l++;
                                if (l == 5) {
                                  l = 0;
                                }
                                TracingViewModal listElements = listViewProvider.tracingListView[i];
                                return GestureDetector(
                                  onTap: () {
                                    listElements.count.toString() == '0'
                                        ? null
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => IssueList(
                                                moduleCode: listElements.code.toString(),
                                                moduleName: listElements.name.toString(),
                                              ),
                                            ),
                                          );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                                    child: Container(
                                      height: size.height / 16,
                                      decoration: BoxDecoration(
                                        color: APPColors.Main.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: APPColors.Main.grey,
                                            blurRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    listElements.name.toString(),
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: listElements.count.toString() == '0' ? APPColors.Main.grey : APPColors.Main.black),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    listElements.count.toString(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(fontSize: 22, color: APPColors.TracingNumber.blue),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
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
            listViewProvider.tracingListView.clear();
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
