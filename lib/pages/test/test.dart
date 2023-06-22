import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../providers/main_page_view_provider.dart';
import '../../utils/themes.dart';
import '../../widgets/cardWidgets/customCardWithImageSmall.dart';
import '../issue/issueDetail.dart';
import '../new_notif/new_notif_base.dart';
import 'package:win_kamu/utils/global_utils.dart';
import 'package:win_kamu/api/api_repository.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final RoundedLoadingButtonController _btnController2 = RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller) async {
    setState(() {
      testv1 = 'loading';
      testv2 = 'loading';
    });
    Timer(Duration(seconds: 1), () {
      erisimTesti();
      controller.success();
      _btnController2.reset();
    });
  }

  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var os = '';
  var model = '';
  var testv1 = 'success';
  var testv2 = 'success';
  var sunucu_saati = '';

  cek() async {
    final info = await deviceInfo.deviceInfo;
    print(info.data['name']);
    var model1 = info.data['name'];
    var os1 = info.data['systemVersion'];
    setState(() {
      os = os1;
      model = model1;
    });
  }

  erisimTesti() async {
    String accessTest1 = await apirepository.accessTest1();
    String accessTest2 = await apirepository.accessTest2('sgnm1032');
    String getServerTimeResponse = await apirepository.getServerTime('sgnm1048', '');
    //print('Durum $getServerTimeResponse');
    // print('access test 1 '+accessTest1);
    // print('access test 2 : '+accessTest2);

    setState(() {
      sunucu_saati = getServerTimeResponse;

      if (accessTest1 == 'success') {
        testv1 = 'success';
      } else {
        testv1 = 'notsuccess';
      }

      if (accessTest2 == 'success') {
        testv2 = 'success';
      } else {
        testv2 = 'notsuccess';
      }
    });
    print('test v1  :  ' + testv1);

    print('test v2  :  ' + testv2);
  }

  @override
  void initState() {
    cek();
    erisimTesti();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewProvide = Provider.of<MainPageViewProvider>(context);

    DateTime now = DateTime.now();
    int gun = now.day;
    int ay = now.month;
    int yil = now.year;

    int hour = now.hour;
    int minute = now.minute;
    int second = now.second;
    print('$hour : $minute : $second');
    var tarih = '$gun/$ay/$yil $hour:$minute:$second';

    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Test',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              actions: [],
            ),
            body: Column(
              children: [
                Container(
                  child: Center(
                    child: Image.asset(
                      'lib/assets/images/profile3.png',
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Windesk Destek',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Kullanıcı Kodu : ' + mainViewProvide.kadi),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Isparta Şehir Hastanesi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Cihaz : ' + model),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('OS : ' + os),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Uygulama Versiyonu : 1.0.0'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Bağlantı Zamanı',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('Sunucu Saati : $sunucu_saati'),
                        Text('Telefon Saati : $tarih'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 45.w,
                          height: 6.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                            onPressed: () {},
                            child: Text('Hata Bildir'),
                          ),
                        ),
                      ),
                      Container(
                        width: 45.w,
                        height: 6.h,
                        child: RoundedLoadingButton(
                          color: Colors.red,
                          successColor: Colors.amber,
                          controller: _btnController2,
                          onPressed: () => _doSomething(_btnController2),
                          valueColor: Colors.white,
                          borderRadius: 20,
                          child: Center(
                            child: Text('Erişim Testi', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              child: testv1 == 'success'
                                  ? Text(
                                      'Windesk : Erişim Başarılı',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : testv1 == 'notsuccess'
                                      ? Text(
                                          'Windesk: Erişim Başarısız',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : Text(
                                          'Windesk: Erişim Bekleniyor...',
                                          style: TextStyle(color: Colors.orange),
                                        ),
                            ),
                            Container(
                              child: testv2 == 'success'
                                  ? Text(
                                      'Mobil Servis : Erişim Başarılı',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : testv2 == 'notsuccess'
                                      ? Text(
                                          'Mobil Servis : Erişim Başarısız',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : Text(
                                          'Mobil Servis : Erişim Bekleniyor...',
                                          style: TextStyle(color: Colors.orange),
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
