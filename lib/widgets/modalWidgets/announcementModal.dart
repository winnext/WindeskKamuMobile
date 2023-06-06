// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:win_kamu/models/announcement.model.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:provider/provider.dart';
import '../../api/api_repository.dart';
import '../../providers/main_page_view_provider.dart';
import '../customInfoNotFound.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({Key? key}) : super(key: key);
  @override
  State<AnnouncementList> createState() => _AnnouncementListState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _AnnouncementListState extends State<AnnouncementList> {
  @override
  void initState() {
    super.initState();
    final mainViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    //mainViewProvider.announcementView.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final mainViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        height: size.height / 1.4,
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Text(
                  'Duyuruları Kapat',
                  style: TextStyle(color: APPColors.Main.white, fontSize: 16),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            mainViewProvider.announcementView.isNotEmpty
                ? Expanded(
                    child: NotificationListener<ScrollNotification>(
                    child: ListView.builder(
                        itemCount: mainViewProvider.announcementView.length,
                        itemBuilder: (BuildContext context, int i) {
                          l++;
                          if (l == 5) {
                            l = 0;
                          }
                          AnnouncementViewModel listElements =
                              mainViewProvider.announcementView[i];
                          bool? isLink =
                              listElements.ANNOUNCEMENT?.contains('http');
                          return GestureDetector(
                            onTap: () {
                              final mainViewProvider =
                                  Provider.of<MainPageViewProvider>(context,
                                      listen: false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: APPColors.Main.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: APPColors.Main.grey,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        listElements.NAME.toString(),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: APPColors.Accent.blue),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: isLink == true
                                            ? Link(
                                                uri: Uri.parse(listElements.ANNOUNCEMENT
                                                    .toString()),
                                                target: LinkTarget.blank,
                                                builder: (BuildContext ctx,
                                                    FollowLink? openLink) {
                                                  return TextButton.icon(
                                                    onPressed: openLink,
                                                    label: const Text(
                                                        'Ankete Git : '),
                                                    icon: const Icon(
                                                        Icons.read_more),
                                                  );
                                                },
                                              )
                                            : Text(
                                                listElements.ANNOUNCEMENT
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: APPColors
                                                        .Secondary.black),
                                              ),
                                      )
                                    ],
                                  ),
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
      ),
    );
  }
}
