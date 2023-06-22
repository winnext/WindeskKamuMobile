import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/searchPage/isEmriArama.dart';
import 'package:win_kamu/pages/searchPage/mahalArama.dart';
import 'package:win_kamu/pages/searchPage/vakaSlaArama.dart';
import 'package:win_kamu/pages/searchPage/varlikArama.dart';
import 'package:win_kamu/utils/page_titles.dart';
import 'package:win_kamu/widgets/appbar/custom_main_appbar.dart';
import 'package:win_kamu/widgets/buttonWidgets/searchButtons.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const CustomMainAppbar(title: PageTitles.searchTitle, returnBack: false),
          body: Center(
            child: SizedBox(
              height: 50.h,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchButton(text: 'Vaka-(SLA) Arama', iconName: Icons.explore, navigator: vakaSlaArama()),
                        ),
                        Expanded(
                          child: SearchButton(text: 'Varlık Arama', iconName: Icons.archive, navigator: varlikArama()),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchButton(text: 'Mahal Arama', iconName: Icons.flag, navigator: mahalArama()),
                        ),
                        Expanded(
                          child: SearchButton(text: 'İş Emri Arama ', iconName: Icons.explore, navigator: isEmriArama()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
