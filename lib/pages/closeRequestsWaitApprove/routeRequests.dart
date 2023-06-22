import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/main_page_view_provider.dart';
import 'closeRequests.dart';

class CloseRequestAwaitApproval extends StatefulWidget {
  static String closeRequest = '/closeRequests';
  const CloseRequestAwaitApproval({super.key});

  @override
  State<CloseRequestAwaitApproval> createState() => _CloseRequestAwaitApprovalState();
}

class _CloseRequestAwaitApprovalState extends State<CloseRequestAwaitApproval> {
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

    return CloseRequestListScreen(pageController: mainViewProvide.pageController!);
  }
}
