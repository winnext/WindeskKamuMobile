import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/main_page_view_provider.dart';
import 'issueTracingList.dart';

class Issue extends StatefulWidget {
  static String openRequest = '/openRequest';
  const Issue({super.key});

  @override
  State<Issue> createState() => _IssueState();
}

class _IssueState extends State<Issue> {
  @override
  void initState() {
    super.initState();
    final mainViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);

    mainViewProvider.initForm();
  }

  @override
  void dispose() {
    final mainViewProvider =
        Provider.of<MainPageViewProvider>(context, listen: false);
    mainViewProvider.pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);

    return IssueTracingList(pageController: mainViewProvide.pageController!);
  }
}
