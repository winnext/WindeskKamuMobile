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
                  listViewProvider.pageController!.jumpTo(0);
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
                                if (listElements.notificationDate
                                    .toString()
                                    .contains(".")) {
                                  DateTime dateTime =
                                      DateFormat("yyyy-MM-ddTHH:mm:ss.SSS")
                                          .parse(listElements.notificationDate
                                              .toString());
                                  formattedDate =
                                      DateFormat("dd/MM/yyyy").format(dateTime);
                                } else {
                                  DateTime dateTime =
                                      DateFormat("yyyy-MM-ddTHH:mm").parse(
                                          listElements.notificationDate
                                              .toString());
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
                                        title: listElements.description == ""
                                            ? "Açıklama ${i + 1}"
                                            : listElements.description,
                                        subTitle: listElements.isRead == false
                                            ? "Okundu"
                                            : "Okunmadı",
                                        isIcon: true,
                                        extraTitle:
                                            "Lorem ipsum dolor sit amet",
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
