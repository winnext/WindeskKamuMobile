import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../l10n/locale_keys.g.dart';
import '../../providers/list_view_provider.dart';
import '../../utils/themes.dart';
import '../../widgets/cardWidgets/customCardWithImage.dart';
import '../../widgets/cardWidgets/customCardWithImageSmall.dart';
import '../../widgets/dialogWidgets/customAlertDialog.dart';
import '../login/login.dart';

class NewNotif extends StatefulWidget {
    static String newNotif = '/newNotif';

  const NewNotif({super.key,String});
  

  @override
  State<NewNotif> createState() => _NewNotifState();

 
}

class _NewNotifState extends State<NewNotif> {

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
      child:  Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: APPColors.Accent.blue,
            title: Text('Yeni Bildirim'),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  index  == 0 ?     Navigator.popUntil(context, (route) => route.isFirst): mainViewProvide.pageController!.jumpTo(0);


                },
                icon: index == 0 ? const Icon(  Icons.arrow_back ) : const Icon(  Icons.home )
                ),
            actions: [],
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
                      height:40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(mainViewProvide.kadi),
                          Text(date),
                          Text(time)
                        ],
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
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'Kan gazı için numune taşıma personel talebi',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 2,
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'Hasta taşım talebi',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 3,
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'İlaç taşıma',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 4,
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'Vefat eden taşıma',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 5,
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'Oda destek personeli',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 6,
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'Malzeme taşıma personel talebi',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 7,
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'Temizlik talebi',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 8,
                            navigation: Login(),
                          ),CustomCardWithImageSmall(
                            title: 'Diğer',
                            iconData: Icons.text_fields,
                            cardPadding: 0,
                            cardInlinePadding: 10,
                            numara: 9,
                            navigation: Login(),
                          ),
                        ]),
                  ],
                ),
              ),
            ],
            
          )
          ),
    );
    });
  }
}