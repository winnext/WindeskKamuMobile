// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/models/list_view.model.dart';
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
import '../homePage.dart';

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
  Widget build(BuildContext context) {
    int l = -1;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    final crudProvider = Provider.of<CrudViewProvider>(context, listen: false);
    print('exlist ' + listViewProvider.exampleListView.length.toString());
    // print(listViewProvider.exampleListView[0].toString());
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.blue,
            title: Text(LocaleKeys.listeleme.tr()),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const MyHomePage())));
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

                                final TARGET_FDATE =
                                    timeRecover(listElements.TARGET_FDATE);
                                final TARGET_RDATE =
                                    timeRecover(listElements.TARGET_RDATE);
                                final time = DateTime.now();
                                final String timeNow = DateFormat('yMMddhhmmss')
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
                                        iconOnPressed: () {
                                          // crudProvider.fillForm(
                                          //     context,
                                          //     listElements,
                                          //     listViewProvider.pageController!);
                                        },
                                        importanceLevelColor: generateColor(l),
                                        code: listElements.CODE.toString(),
                                        targetFDate: listElements.TARGET_FDATE,
                                        targetRDate: listElements.TARGET_RDATE,
                                        taskNo: i.toString(),
                                        description:
                                            listElements.DESCRIPTION.toString(),
                                        sumdesc1:
                                            listElements.SUMDESC1.toString(),
                                        statusName:
                                            listElements.STATUSNAME.toString(),
                                        space: listElements.SPACE.toString(),
                                        location:
                                            listElements.LOCATION.toString(),
                                        idate: listElements.IDATE.toString(),
                                        statusCode:
                                            listElements.STATUSCODE.toString(),
                                        planedDate:
                                            listElements.PLANNEDDATE.toString(),
                                        respondedIDate: listElements
                                            .RESPONDED_IDATE
                                            .toString(),
                                        responseTimer: listElements
                                            .response_timer
                                            .toString(),
                                        fixedTimer:
                                            listElements.fixed_timer.toString(),
                                        fixedIDate:
                                            listElements.FIXED_IDATE.toString(),
                                        timeInfoNow: timeNow,
                                        isIcon: true,
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

timeRecover(timeInfo) {
  String finalTime;
  print('asdf' + timeInfo);
  final timeZone = timeInfo.toString().substring(0, 4) +
      '-' +
      timeInfo.toString().substring(4, 6) +
      '-' +
      timeInfo.toString().substring(6, 8) +
      'T' +
      timeInfo.toString().substring(8, 10) +
      ':' +
      timeInfo.toString().substring(10, 12) +
      ':' +
      timeInfo.toString().substring(12, 14);
  print('asdff' + timeZone);

  if (timeZone.toString().contains(".")) {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(timeZone.toString());
    finalTime = DateFormat("yyyy-MM-dd").format(dateTime);
  } else {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm").parse(timeZone.toString());
    finalTime = DateFormat("dd/MM/yyyy").format(dateTime);
  }
  print('finalTime ' + finalTime);
  return finalTime;
}

moreLess(numberOne, numberTwo) {
  int numberOnetoInt = int.parse(numberOne);
  int numberTwotoInt = int.parse(numberTwo);
  print('numbers' + numberTwotoInt.toString());
  print('numberss' + numberTwotoInt.toString());

  if (numberOnetoInt - numberTwotoInt < 0) {
    return -10;
  } else {
    return 10;
  }
}
