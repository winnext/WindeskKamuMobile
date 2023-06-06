// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:win_kamu/models/issue_activities.modal.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../api/api_repository.dart';
import '../../models/issue_notes.modal.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/modalWidgets/issueActionModal.dart';

class IssueNotes extends StatefulWidget {
  static String noteList = 'noteList';

  const IssueNotes({Key? key}) : super(key: key);
  @override
  State<IssueNotes> createState() => _IssueNotesState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _IssueNotesState extends State<IssueNotes> {
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: false);
    exampleList.issueNotesView.clear();
    exampleList.getIssueNotes(detailViewProvider.issueCode);
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height / 1.7,
            child: Column(
              children: [
                listViewProvider.issueNotesView.length > 0
                    ? Expanded(
                        child: NotificationListener<ScrollNotification>(
                        // onNotification: listViewProvider.notificationController,
                        child: ListView.builder(
                            itemCount:
                                listViewProvider.issueNotesView.length,
                            itemBuilder: (BuildContext context, int i) {
                              l++;
                              if (l == 5) {
                                l = 0;
                              }
                              IssueNotesModal listElements =
                                  listViewProvider.issueNotesView[i];
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(width: size.width/ 2, child: Text(listElements.IUSER.toString())),
                                          Text(listElements.IDATE.toString()),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 10),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(''),
                                                Text(listElements.BODY
                                                    .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 10,
                                        color: APPColors.Main.grey,
                                        thickness: 5.0,
                                      )
                                    ],
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
          ),
          if (listViewProvider.isDataLoading == true) ...[
            loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final detailViewProvider =
          Provider.of<DetailViewProvider>(context, listen: false);
          final mainPageViewProvider =
          Provider.of<MainPageViewProvider>(context, listen: false);
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => IssueActionButton(
                  code: detailViewProvider.issueCode, xusercode: mainPageViewProvider.kadi));
        },
        backgroundColor: APPColors.Modal.red,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  Widget sayfaYenile() {
    return Consumer<ListViewProvider>(
        builder: (context, listViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            listViewProvider.setisDataLoading = true;
            listViewProvider.issueNotesView.clear();
            listViewProvider.getIssueNotes(listViewProvider.moduleCode);
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
