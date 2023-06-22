import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../providers/main_page_view_provider.dart';
import 'openRequests.dart';

class OpenRequests extends StatefulWidget {
  static String openRequest = '/openRequest';
  const OpenRequests({super.key});

  @override
  State<OpenRequests> createState() => _OpenRequestsState();
}

class _OpenRequestsState extends State<OpenRequests> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    final mainViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);

    mainViewProvider.initForm();
  }

  @override
  void dispose() {
    final mainViewProvider = Provider.of<MainPageViewProvider>(context, listen: false);
    mainViewProvider.pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);

    return ListScreen(pageController: mainViewProvide.pageController!);
  }
}
