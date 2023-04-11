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
import '../../models/tracing_view.model.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customOpenIssueWidget.dart';
import '../homePage.dart';
import 'issueDetail.dart';
import 'issueList.dart';

class IssueTracingList extends StatefulWidget {
  static String pageName = 'listPage';

  const IssueTracingList({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  State<IssueTracingList> createState() => _IssueTracingListState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _IssueTracingListState extends State<IssueTracingList> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    final mainViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    exampleList.tracingListView.clear();
    exampleList.getTracingListWithCount('sgnm1027', 'issue');
    exampleList.initData(widget.pageController);
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

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              'Vaka Listesi',
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  listViewProvider.pageController!.jumpTo(0);
                  //   Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black),
                onPressed: () {},
              ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  listViewProvider.tracingListView.isNotEmpty
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                          onNotification:
                              listViewProvider.notificationController,
                          child: ListView.builder(
                              itemCount:
                                  listViewProvider.tracingListView.length,
                              itemBuilder: (BuildContext context, int i) {
                                l++;
                                if (l == 5) {
                                  l = 0;
                                }
                                TracingViewModal listElements =
                                    listViewProvider.tracingListView[i];
                                return GestureDetector(
                                  onTap: () {
                                    final mainViewProvider =
                                        Provider.of<MainPageViewProvider>(
                                            context,
                                            listen: false);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => IssueList(
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
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: APPColors.Main.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: APPColors.Main.grey,
                                            blurRadius: 1,
                                            offset: Offset(0, 2),
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
                                                    flex: 1,
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
            listViewProvider.tracingListView.clear();
            listViewProvider.setcurrentPage = 1;
            listViewProvider.loadData(
                listViewProvider.currentPage, 'OpenIssuesIsCustomer');
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