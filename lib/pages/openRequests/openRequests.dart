// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:win_kamu/widgets/commons.dart';
import 'package:provider/provider.dart';
import '../../api/api_repository.dart';
import '../../l10n/locale_keys.g.dart';
import '../../utils/global_utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customTaskListWidget.dart';

class ListScreen extends StatefulWidget {

  static String pageName = 'listPage';

  const ListScreen({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.exampleListView.clear();
    exampleList.loadData(1);
    exampleList.initData(widget.pageController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    final crudProvider = Provider.of<CrudViewProvider>(context, listen: false);
    int index = listViewProvider.currentPage;
    print('exlist ' + listViewProvider.exampleListView.length.toString());
    // print(listViewProvider.exampleListView[0].toString());



    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Accent.blue,
            title: Text(LocaleKeys.listeleme.tr()),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  print('index');
                  print(index);
                  try {
                  listViewProvider.pageController!.jumpTo(0); 
                  } catch (e) {
                    dispose();
                   Navigator.of(context).pushReplacementNamed('/mainPage');

                  }
                },
                icon: const Icon(Icons.home)),
            actions: [sayfaYenile()],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  pageCard(
                      context, LocaleKeys.listOrnekleri.tr(), logoHeader()),
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

                                final timeZone = listElements.TARGET_FDATE
                                        .toString()
                                        .substring(0, 4) +
                                    '-' +
                                    listElements.TARGET_FDATE
                                        .toString()
                                        .substring(4, 6) +
                                    '-' +
                                    listElements.TARGET_FDATE
                                        .toString()
                                        .substring(6, 8) +
                                    'T' +
                                    listElements.TARGET_FDATE
                                        .toString()
                                        .substring(8, 10) +
                                    ':' +
                                    listElements.TARGET_FDATE
                                        .toString()
                                        .substring(10, 12) +
                                    ':' +
                                    listElements.TARGET_FDATE
                                        .toString()
                                        .substring(12, 14);

                                if (timeZone.toString().contains(".")) {
                                  DateTime dateTime =
                                      DateFormat("yyyy-MM-ddTHH:mm:ss.SSS")
                                          .parse(timeZone.toString());
                                  formattedDate =
                                      DateFormat("dd/MM/yyyy").format(dateTime);
                                } else {
                                  DateTime dateTime =
                                      DateFormat("yyyy-MM-ddTHH:mm")
                                          .parse(timeZone.toString());
                                  formattedDate =
                                      DateFormat("dd/MM/yyyy").format(dateTime);
                                }

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TaskListWidget(
                                        iconOnPressed: () {
                                          crudProvider.fillForm(
                                              context,
                                              listElements,
                                              listViewProvider.pageController!);
                                        },
                                        importanceLevelColor: generateColor(l),
                                        trailing: formattedDate,
                                        taskNo: i.toString(),
                                        title: listElements.CODE.toString(),
                                        subTitle:
                                            listElements.DESCRIPTION.toString(),
                                        isIcon: true,
                                        extraTitle:
                                            listElements.STATUSCODE.toString(),
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
            listViewProvider.loadData(listViewProvider.currentPage);
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