import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/closeRequestsWaitApprove/routeRequests.dart';
import 'package:win_kamu/pages/searchPage/isEmriArama.dart';
import 'package:win_kamu/pages/searchPage/mahalArama.dart';
import 'package:win_kamu/pages/searchPage/vakaSlaArama.dart';
import 'package:win_kamu/pages/searchPage/varlikArama.dart';
import 'package:win_kamu/widgets/buttonWidgets/searchButtons.dart';

import '../../utils/themes.dart';
import '../../widgets/buttonWidgets/homeButtons.dart';
import '../complaintRequests/routeRequests.dart';
import '../issue/routeIssue.dart';
import '../new_notif/new_notif.dart';
import '../openRequests/RouteRequests.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(      builder: (context, orientation, deviceType) {
    
    return Container(
      child:  Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Arama',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            
            actions: [],
          ),
          body: Center(
            child: Container(
              height: 50.h,
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchButton(
                                  text: 'Vaka-(SLA) Arama',
                                  iconName: Icons.explore,
                                  navigator: vakaSlaArama()),
                            ),
                            Expanded(
                              child: SearchButton(
                                  text: 'Varlık Arama',
                                  iconName: Icons.archive,
                                  navigator: varlikArama()
                                  ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchButton(
                                  text: 'Mahal Arama',
                                  iconName: Icons.flag,
                                  navigator: mahalArama()
                                  ),
                            ),
                            Expanded(
                              child: SearchButton(
                                  text: 'İş Emri Arama ',
                                  iconName: Icons.explore,
                                  navigator: isEmriArama()
                              ),
                            )
                          ],
                        ),
                      ),
                     
                    ],
                  ),
            ),
          )
          ),
    );
  }
    );
  }
}