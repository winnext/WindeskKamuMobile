import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'issueActivities.dart';
import 'issueDetail.dart';
import 'issueFiles.dart';
import 'issueList.dart';
import 'issueNotes.dart';
import '../../providers/main_page_view_provider.dart';
import '../../utils/api_urls.dart';
import '../../utils/themes.dart';

import '../../providers/detail_view_provider.dart';
import '../../providers/issueaction_provider.dart';
import '../../providers/list_view_provider.dart';

void main() => runApp(const IssueSummary());

class IssueSummary extends StatelessWidget {
  const IssueSummary({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({super.key});

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  @override
  void initState() {
    super.initState();

    final listViewProvider = Provider.of<ListViewProvider>(context, listen: false);
    final issueActionProvider = Provider.of<IssueActionProvider>(context, listen: false);
    final detailViewProvider = Provider.of<DetailViewProvider>(context, listen: false);
    final mainPageViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);

    final String issueCode = detailViewProvider.issueCode.toString();

    issueActionProvider.setactivityCode = '';
    issueActionProvider.setactivityName = '';
    listViewProvider.getIssueOperations(issueCode, mainPageViewProvider.kadi);
    issueActionProvider.getAvailableActivities(issueCode);
    issueActionProvider.getLiveSelectAsgGroups(issueCode);
  }

  @override
  Widget build(BuildContext context) {
    final listViewProvider = Provider.of<ListViewProvider>(context);

    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: PPP_PROJECT == "antep" ? 4 : 3,
      child: Scaffold(
        appBar: _issueSummaryAppbar(size, context, listViewProvider),
        body: const TabBarView(
          children: PPP_PROJECT == "antep"
              ? <Widget>[IssueDetail(), IssueActivities(), IssueFiles(), IssueNotes()]
              : <Widget>[
                  IssueDetail(),
                  IssueActivities(),
                  IssueFiles(),
                ],
        ),
      ),
    );
  }

  AppBar _issueSummaryAppbar(Size size, BuildContext context, ListViewProvider listViewProvider) {
    return AppBar(
      title: const Text(
        'Vaka Listesi Detay',
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      backgroundColor: APPColors.Main.white,
      toolbarHeight: size.height / 20,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IssueList(
                  moduleCode: listViewProvider.moduleCode.toString(),
                  moduleName: listViewProvider.moduleName.toString(),
                ),
              ))
        },
        icon: Icon(Icons.arrow_back_rounded, color: APPColors.Main.black),
        alignment: Alignment.topCenter,
      ),
      bottom: const TabBar(
        indicatorColor: Colors.black,
        labelStyle: TextStyle(fontSize: 11),
        labelColor: Colors.black,
        tabs: PPP_PROJECT == "antep"
            ? <Widget>[
                Tab(
                  text: 'Özet',
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Tab(
                  text: 'Aktivite',
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Tab(
                  text: 'Dosyalar',
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Tab(
                  text: 'Notlar',
                  icon: Icon(
                    Icons.note_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ]
            : <Widget>[
                Tab(
                  text: 'Özet',
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Tab(
                  text: 'Aktivite',
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Tab(
                  text: 'Dosyalar',
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ],
      ),
    );
  }
}
