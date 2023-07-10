import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/main_page_view_provider.dart';
import 'closedRequests.dart';

class ClosedRequests extends StatefulWidget {
  static String closedRequests = '/ClosedRequests';
  const ClosedRequests({super.key});

  @override
  State<ClosedRequests> createState() => _ClosedRequestsState();
}

class _ClosedRequestsState extends State<ClosedRequests> {
  final int _currentIndex = 0;
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

    return ClosedRequestListScreen(pageController: mainViewProvide.pageController!);
  }
}
