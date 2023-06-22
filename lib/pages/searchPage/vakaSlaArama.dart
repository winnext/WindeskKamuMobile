import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/providers/search_view_provider.dart';
import 'package:win_kamu/utils/global_utils.dart';
import 'package:win_kamu/utils/page_titles.dart';
import 'package:win_kamu/widgets/appbar/custom_main_appbar.dart';

import '../../providers/detail_view_provider.dart';
import '../../providers/login_provider.dart';
import '../../utils/themes.dart';
import '../issue/issueSummary.dart';

class vakaSlaArama extends StatefulWidget {
  const vakaSlaArama({super.key});

  @override
  State<vakaSlaArama> createState() => _vakaSlaAramaState();
}

class _vakaSlaAramaState extends State<vakaSlaArama> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchViewProvider>(context);

    TextEditingController vakaNoController = TextEditingController();
    var vakaNo = 0;

    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const CustomMainAppbar(title: PageTitles.caseSLASearchTitle, returnBack: true),
          body: Center(
              child: Container(
            width: 85.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: searchProvider.vakaNo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Vaka No',
                  ),
                  onChanged: (inputValue) {
                    print(searchProvider.vakaNo.text);
                    if (searchProvider.vakaNo.text == '') {
                      vakaNo = 0;

                      searchProvider.setVakaButonVisible = false;
                    } else {
                      vakaNo = 1;
                      searchProvider.setVakaButonVisible = true;
                    }
                  },
                ),
                searchProvider.vakaNo.text != ''
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 45.w,
                          height: 8.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: APPColors.Main.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              searchProvider.setVakaNo = '';
                            },
                            child: const Text('Temizle'),
                          ),
                        ),
                      )
                    : Text(''),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 45.w,
                    height: 8.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: APPColors.Login.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // <-- Radius
                        ),
                      ),
                      onPressed: () {
                        print(searchProvider.vakaNo.text);

                        if (searchProvider.vakaNo.text.length != 0) {
                          final detailViewProvider = Provider.of<DetailViewProvider>(context, listen: false);
                          print(searchProvider.vakaNo.text);
                          detailViewProvider.setIssueCode = '';
                          detailViewProvider.setIssueCode = searchProvider.vakaNo.text;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const IssueSummary(),
                            ),
                          );
                        } else {
                          snackBar(context, 'Boş alan bırakmayınız.', 'info');
                        }
                      },
                      child: const Text('Ara'),
                    ),
                  ),
                ),
              ],
            ),
          )));
    });
  }
}
