import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../providers/main_page_view_provider.dart';
import 'closedRequests.dart';

class ClosedRequest extends StatefulWidget {
  static String closedRequest = '/closeRequests';
  const ClosedRequest({super.key});

  @override
  State<ClosedRequest> createState() => _ClosedRequestState();
}

class _ClosedRequestState extends State<ClosedRequest> {
  int _currentIndex = 0;
  PageController? _pageController;

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

    return ClosedRequestListScreen(pageController: mainViewProvide.pageController!);
  }
}
