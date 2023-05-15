import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/pages/issue/issueActivities.dart';
import 'package:win_kamu/pages/issue/issueDetail.dart';
import 'package:win_kamu/pages/issue/issueFiles.dart';
import 'package:win_kamu/pages/issue/issueList.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';

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

    final listViewProvider =
        Provider.of<ListViewProvider>(context, listen: false);
    final issueActionProvider =
        Provider.of<IssueActionProvider>(context, listen: false);
    //final detailViewProvider = Provider.of<DetailViewProvider>(context);
    //final mainPageViewProvider = Provider.of<MainPageViewProvider>(context);

    //final String issueCode = detailViewProvider.issueCode.toString();

    issueActionProvider.setactivityCode = '';
    issueActionProvider.setactivityName = '';
    listViewProvider.getIssueOperations('AEH00334105', 'sgnm1040');
    issueActionProvider.getAvailableActivities('AEH00334105');
    issueActionProvider.getLiveSelectAsgGroups('AEH00334105');
    issueActionProvider
        .getLiveSelectAsgUser(issueActionProvider.liveSelectGroupCode);
    print('issueCode' +
        issueActionProvider.activityListView[0].ACTIVITYID.toString());
  }

  @override
  Widget build(BuildContext context) {
    final listViewProvider = Provider.of<ListViewProvider>(context);

    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Vaka Listesi Detay',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          backgroundColor: APPColors.Main.white,
          toolbarHeight: size.height / 30,
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
            icon: Icon(Icons.arrow_back_ios_new, color: APPColors.Main.black),
            alignment: Alignment.topCenter,
          ),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelStyle: TextStyle(fontSize: 11),
            labelColor: Colors.black,
            tabs: <Widget>[
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
        ),
        body: const TabBarView(
          children: <Widget>[
            IssueDetail(),
            IssueActivities(),
            IssueFiles(),
          ],
        ),
      ),
    );
  }
}
