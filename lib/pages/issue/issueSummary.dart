import 'package:flutter/material.dart';
import 'package:win_kamu/pages/issue/issueActivities.dart';
import 'package:win_kamu/pages/issue/issueDetail.dart';
import 'package:win_kamu/utils/themes.dart';

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

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vaka Listesi Detay', style: TextStyle(color: Colors.black),),
          backgroundColor: APPColors.Main.white,
          toolbarHeight: size.height / 40,
          bottom: const TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.info_outline, color: Colors.black, ),
              ),
              Tab(
                icon: Icon(Icons.menu, color: Colors.black),
              ),
              Tab(
                icon: Icon(Icons.attach_file, color: Colors.black),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            IssueDetail(),
            IssueActivities(),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
