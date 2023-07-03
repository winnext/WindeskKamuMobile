import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/workorder_detail_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';
import '../../utils/utils.dart';

class WoSpareParts extends StatefulWidget {
  final woCode;

  const WoSpareParts({super.key, required this.woCode});

  @override
  State<WoSpareParts> createState() => _WoSparePartsState();
}

class _WoSparePartsState extends State<WoSpareParts> {
  @override
  void initState() {
    final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: false);
    woDetailViewProvider.getStore();
    woDetailViewProvider.getProducts(woDetailViewProvider.secilenDepo);
    print('depolar  :  ');
    print(woDetailViewProvider.depolarArray);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: true);

    List<String> dataListDepo = woDetailViewProvider.depolarArray[1];
    List<String> dataListUrunler = woDetailViewProvider.depoUrunlerArray[1];

    print('dataListDepo : ');
    print(dataListDepo);

    return Sizer(builder: (context, Orientation, DeviceType) {
      return Container(
        child: SizedBox(
          child: Center(
              child: Column(
            children: [
              Expanded(
                child: SizedBox(
                    height: 10.h,
                    child: Text(
                      'Depo Seçimii.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: font_size_16),
                    )),
              ),
              Expanded(
                child: SizedBox(
                  height: 30.h,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      isExpanded: true,

                      // Initial Value
                      value: 'Lütfen Depo Seçiniz',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Depo',
                      ),

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: dataListDepo.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value

                      onChanged: (String? newValue) {
                        print('SEÇİLEN DEGER : ' + newValue.toString());
                        setState(() {
                          woDetailViewProvider.setDepoDegeri =
                              newValue.toString();
                          String valueDegeri =
                              woDetailViewProvider.depolarArray[0]
                                  [dataListDepo.indexOf(newValue.toString())];
                          print('SECİLEN DEGER VALUE DEGERİ' + valueDegeri);
                          woDetailViewProvider.setDepoDegeriValue = valueDegeri;
                          woDetailViewProvider.getProducts(valueDegeri);
                        });

                        print(woDetailViewProvider.secilenDepo);
                      },
                    ),
                  ),
                ),
              ),
              woDetailViewProvider.secilenDepo != ''
                  ? Expanded(
                      child: SizedBox(
                        height: 30.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            isExpanded: true,

                            // Initial Value
                            value: woDetailViewProvider.secilenDepoUrunSecimi,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelText: 'Ürün Seçimi',
                            ),

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: dataListUrunler.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              print(newValue.toString());
                              setState(() {
                                woDetailViewProvider.setSureDegeri =
                                    newValue.toString();
                              });

                              print(woDetailViewProvider.secilenSure);
                            },
                          ),
                        ),
                      ),
                    )
                  : Text(''),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                      width: 60.w,
                      height: 5.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: APPColors.Login.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                ),
                              ),
                              onPressed: () {
                                woDetailViewProvider.setSureDegeri =
                                    'Lütfen Süre Seçiniz';
                                woDetailViewProvider.setSecilenGun = '0';
                                woDetailViewProvider.setSecilenSaat = '0';
                                woDetailViewProvider.setSecilenDakika = '0';
                              },
                              child: (Text('Vazgeç')),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: APPColors.Login.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                              ),
                              onPressed: () {
                                String workPeriod = '';
                                if (woDetailViewProvider.secilenSure ==
                                    'Lütfen Süre Seçiniz') {
                                  snackBar(
                                      context,
                                      'Süre seçmeden efor oluşturamazsınız',
                                      'info');
                                } else {
                                  if (woDetailViewProvider.secilenSure ==
                                      'Serbest Seçim') {
                                    if (woDetailViewProvider.secilenGun !=
                                            '0' ||
                                        woDetailViewProvider.secilenSaat !=
                                            '0' ||
                                        woDetailViewProvider.secilenDakika !=
                                            '0') {
                                      String dayValue = '';
                                      String saatValue = '';
                                      String dakikaValue = '';
                                      //Gun degeri
                                      if (woDetailViewProvider
                                              .secilenGun.length ==
                                          1) {
                                        dayValue = '00' +
                                            woDetailViewProvider.secilenGun;
                                      } else if (woDetailViewProvider
                                              .secilenGun.length ==
                                          2) {
                                        dayValue = '0' +
                                            woDetailViewProvider.secilenGun;
                                      } else if (woDetailViewProvider
                                              .secilenGun.length ==
                                          3) {
                                        dayValue =
                                            woDetailViewProvider.secilenGun;
                                      }

                                      //Saat degeri
                                      if (woDetailViewProvider
                                              .secilenSaat.length ==
                                          1) {
                                        saatValue = '0' +
                                            woDetailViewProvider.secilenSaat;
                                      } else if (woDetailViewProvider
                                              .secilenSaat.length ==
                                          2) {
                                        saatValue =
                                            woDetailViewProvider.secilenSaat;
                                      }

                                      //Dakika degeri
                                      if (woDetailViewProvider
                                              .secilenDakika.length ==
                                          1) {
                                        dakikaValue = '0' +
                                            woDetailViewProvider.secilenDakika;
                                      } else if (woDetailViewProvider
                                              .secilenDakika.length ==
                                          2) {
                                        dakikaValue =
                                            woDetailViewProvider.secilenDakika;
                                      }

                                      workPeriod = dayValue +
                                          saatValue +
                                          dakikaValue +
                                          '00';
                                    } else {
                                      snackBar(context,
                                          'En az bir değer giriniz', 'info');
                                    }
                                  } else {
                                    if (woDetailViewProvider.secilenSure ==
                                        '15 dk') {
                                      workPeriod = '000' + '00' + '15' + '00';
                                    } else if (woDetailViewProvider
                                            .secilenSure ==
                                        '30 dk') {
                                      workPeriod = '000' + '00' + '30' + '00';
                                    } else if (woDetailViewProvider
                                            .secilenSure ==
                                        '45 dk') {
                                      workPeriod = '000' + '00' + '45' + '00';
                                    } else if (woDetailViewProvider
                                            .secilenSure ==
                                        '1 sa') {
                                      workPeriod = '000' + '01' + '00' + '00';
                                    } else if (woDetailViewProvider
                                            .secilenSure ==
                                        '2 sa') {
                                      workPeriod = '000' + '02' + '00' + '00';
                                    } else if (woDetailViewProvider
                                            .secilenSure ==
                                        '6 sa') {
                                      workPeriod = '000' + '06' + '00' + '00';
                                    }
                                  }

                                  woDetailViewProvider.addEffort(
                                      context, widget.woCode, workPeriod);
                                }
                              },
                              child: Text('Oluştur'),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            ],
          )),
        ),
      );
    });
  }
}








// showModalBottomSheet<void>(
//             // context and builder are
//             // required properties in this widget
//             context: context,
//             builder: (BuildContext context) {
//               // we set up a container inside which
//               // we create center column and display text
 
//               // Returning SizedBox instead of a Container
//               return SizedBox(
//                 height: 50.h,
//                 child: Center(
//                   child: Column(
//                     children: [
//                      Expanded(child: 
//                       SizedBox(
//                         height: 10.h,
//                         child: Text('Lütfen Süre Seçiniz.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: font_size_16),)
//                         ),
//                      ),
//                      Expanded(child: 
//                       SizedBox(
//                         height: 30.h,
//                         child:  Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: 
//                      DropdownButtonFormField(
//                           isExpanded: true,

//               // Initial Value
//               value: woDetailViewProvider.secilenSure,
//               decoration: InputDecoration(
                                  
//                                   border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                                   labelText: 'Süre',
//                                 ),
              
              
                
//               // Down Arrow Icon
//               icon: const Icon(Icons.keyboard_arrow_down),    
                
//               // Array list of items
//               items: dataListSure.map((String items) {
//                 return DropdownMenuItem(
//                   value: items,
//                   child: Text(items),
//                 );
//               }).toList(),
//               // After selecting the desired option,it will
//               // change button value to selected value
//               onChanged: (String? newValue) { 
//                                print(newValue.toString());
//                                 setState(() {
//                                     woDetailViewProvider.setSureDegeri = newValue.toString();

//                                   });

               
//                print(woDetailViewProvider.secilenSure);
               
//               },
//             ),
//                   ),
//                       ),
//                      ),
//                      woDetailViewProvider.secilenSure == 'Serbest Seçim' ? 
//                     Text('asd') : Text(''),
//                       Expanded(child: 
//                       Padding(
//                          padding: const EdgeInsets.only(bottom: 10),
//                          child: SizedBox(
//                               width: 60.w,
//                               height: 5.h,
//                               child: Row(
//                                 children: [
//                                    SizedBox(
//                                      width: 30.w,
//                                      child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               primary: APPColors.Login.red,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                       BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     bottomLeft: Radius.circular(20)
//                                   ),
//                               ),
//                             ),
//                             onPressed: () { 
//                                                             print('Deger');

//                             },
//                             child: (Text('Vazgeç')),
//                           ),
//                                    ),
                       
                                   
                                   
//                                     SizedBox(
//                                      width: 30.w,
//                                      child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               primary: APPColors.Login.blue,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.only(
//                                     topRight: Radius.circular(20),
//                                     bottomRight: Radius.circular(20)
//                                   ),
                                   
//                               ),
//                             ),
//                             onPressed: () {
//                               print('Deger');
//                               print(woDetailViewProvider.secilenSure);
//                               snackBar(context, woDetailViewProvider.secilenSure, 'info');
//                             },
//                             child: Text('Oluştur'),
//                           ),
//                                    ),
                                   
//                                 ],
//                               )
//                             ),
//                        ),
//                       )
                      
//                     ],
//                   )
//                 ),
//               );
//             },
//           );

