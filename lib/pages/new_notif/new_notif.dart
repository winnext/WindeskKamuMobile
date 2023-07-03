import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'new_notif_base.dart';
import '../../providers/main_page_view_provider.dart';
import '../../providers/new_notif_provider.dart';
import '../../widgets/appbar/custom_main_appbar.dart';

import '../../l10n/locale_keys.g.dart';
import '../../utils/themes.dart';
import '../../widgets/cardWidgets/customCardWithImageSmall.dart';

class NewNotif extends StatefulWidget {
  static String newNotif = '/newNotif';

  const NewNotif({super.key, String});

  @override
  State<NewNotif> createState() => _NewNotifState();
}

class _NewNotifState extends State<NewNotif> {
  @override
  void initState() {
    super.initState();
    final nProvider = Provider.of<NewNotifProvider>(context, listen: false);
  }

  String time = "";

  String date = '';

  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);
    int index = mainViewProvide.currentIndex;

    String datetime = DateTime.now().toString();
    print(datetime);

    return Resize(builder: () {
      return Container(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: CustomMainAppbar(
              title: LocaleKeys.newNotif,
              leading: IconButton(
                onPressed: () {
                  index == 0 ? Navigator.popUntil(context, (route) => route.isFirst) : mainViewProvide.pageController!.jumpTo(0);
                },
                icon: index == 0 ? const Icon(Icons.arrow_back) : const Icon(Icons.home),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(5),
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        color: APPColors.NewNotifi.red,
                        height: 40.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Text(mainViewProvide.kadi), Text(date), Text(time)],
                        ),
                      ),
                      GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 10,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            CustomCardWithImageSmall(
                              title: 'Numune taşıma personel talebi',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 1,
                              navigation: NewNotifBase(
                                sayfa: 'Numune taşıma personel talebi',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'Kan gazı için numune taşıma personel talebi',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 2,
                              navigation: NewNotifBase(
                                sayfa: 'Kan gazı için numune taşıma personel talebi',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'Hasta taşıma talebi',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 3,
                              navigation: NewNotifBase(
                                sayfa: 'Hasta taşıma talebi',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'İlaç taşıma',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 4,
                              navigation: NewNotifBase(
                                sayfa: 'İlaç taşıma',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'Vefat eden taşıma',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 5,
                              navigation: NewNotifBase(
                                sayfa: 'Vefat eden taşıma',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'Oda destek personeli',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 6,
                              navigation: NewNotifBase(
                                sayfa: 'Oda destek personeli',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'Malzeme taşıma personel talebi',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 7,
                              navigation: NewNotifBase(
                                sayfa: 'Malzeme taşıma personel talebi',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'Temizlik talebi',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 8,
                              navigation: NewNotifBase(
                                sayfa: 'Temizlik talebi',
                              ),
                            ),
                            CustomCardWithImageSmall(
                              title: 'Diğer',
                              iconData: Icons.text_fields,
                              cardPadding: 0,
                              cardInlinePadding: 10,
                              numara: 9,
                              navigation: NewNotifBase(
                                sayfa: 'Diğer',
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
