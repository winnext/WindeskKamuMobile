// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/api_urls.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../api/api_repository.dart';
import '../../models/issue_attachments.modal.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/modalWidgets/issueActionModal.dart';
import '../../widgets/photoDisplayWidgets/customActivitiesPhoto.dart';

class IssueFiles extends StatefulWidget {
  static String activitiesList = 'ActivitiesList';

  const IssueFiles({Key? key}) : super(key: key);
  @override
  State<IssueFiles> createState() => _IssueFilesState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _IssueFilesState extends State<IssueFiles>
    with AutomaticKeepAliveClientMixin<IssueFiles> {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: false);
    final mainpageViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);
    exampleList.issueAttachmentView.clear();
    exampleList.getIssueAttachments(mainpageViewProvider.kadi, detailViewProvider.issueCode);
  }

  @override
  void dispose() {
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
          SizedBox(
            height: size.height / 1.7,
            child: Column(
              children: [
                listViewProvider.issueAttachmentView.isNotEmpty
                    ? Expanded(
                        child: NotificationListener<ScrollNotification>(
                        child: ListView.builder(
                            itemCount:
                                listViewProvider.issueAttachmentView.length,
                            itemBuilder: (BuildContext context, int i) {
                              l++;
                              if (l == 5) {
                                l = 0;
                              }

                              IssueAttachmentModal listElements =
                                  listViewProvider.issueAttachmentView[i];
                              final fileUrl =
                                  ATTACHPATHLIVE + listElements.ID.toString();
                              bool? isPDF =
                                  listElements.DISPFILENAME?.contains('pdf');
                              bool? isXLSX =
                                  listElements.DISPFILENAME?.contains('xlsx');
                              bool? isDOCX =
                                  listElements.DISPFILENAME?.contains('docx');
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: size.width / 2.5,
                                                child: Text('${listElements
                                                        .DISPFILENAME} ${listElements.ID}'),
                                              ),
                                              Text(
                                                  listElements.IDATE.toString())
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 10),
                                              child: (isPDF == true ||
                                                      isXLSX == true ||
                                                      isDOCX == true)
                                                  ? Link(
                                                      uri: Uri.parse(fileUrl),
                                                      target: LinkTarget.blank,
                                                      builder:
                                                          (BuildContext ctx,
                                                              FollowLink?
                                                                  openLink) {
                                                        return TextButton.icon(
                                                          onPressed: openLink,
                                                          label: const Text(
                                                              'Linke tıklayınız'),
                                                          icon: const Icon(
                                                              Icons.read_more),
                                                        );
                                                      },
                                                    )
                                                  : ActivitiesPhoto(
                                                      photoAdress: fileUrl,
                                                    )),
                                        ],
                                      ),
                                      Divider(
                                        height: 10,
                                        color: APPColors.Main.grey,
                                        thickness: 5.0,
                                      ),
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
                  code: detailViewProvider.issueCode,
                  xusercode: mainPageViewProvider.kadi));
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
            listViewProvider.issueAttachmentView.clear();
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
