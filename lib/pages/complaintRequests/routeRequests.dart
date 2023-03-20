import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/pages/complaintRequests/routeRequests.dart';

import '../../providers/main_page_view_provider.dart';
import 'complaintRequests.dart';

class ComplaintRequests extends StatefulWidget {
  static String complaintRequests = '/complaintRequests';
  const ComplaintRequests({super.key});

  @override
  State<ComplaintRequests> createState() => _ComplaintRequestsState();
}

class _ComplaintRequestsState extends State<ComplaintRequests> {
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

    return ComplaintReuestsListScreen(pageController: mainViewProvide.pageController!);
  }
}
