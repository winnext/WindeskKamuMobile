// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/workorder_detail_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';
import '../../utils/utils.dart';

class WoEforts extends StatefulWidget {
  final woCode;

  const WoEforts({super.key, required this.woCode});

  @override
  State<WoEforts> createState() => _WoEfortsState();
}

class _WoEfortsState extends State<WoEforts> {
  final dataListSure = ["Lütfen Süre Seçiniz", "15 dk", "30 dk", "45 dk", "1 sa", "2 sa", "6 sa", "Serbest Seçim"];
  final String _pleaseSelectDate = 'Lütfen Tarih Seçiniz';
  final String _labelDate = 'Süre';

  @override
  Widget build(BuildContext context) {
    List<String> dataListGun = [];
    List<String> dataListSaat = [];
    List<String> dataListDakika = [];

    for (var i = 0; i <= 100; i++) {
      dataListGun.add(i.toString());
    }
    for (var x = 0; x <= 23; x++) {
      dataListSaat.add(x.toString());
    }
    for (var i = 0; i <= 59; i++) {
      dataListDakika.add(i.toString());
    }

    final woDetailViewProvider = Provider.of<WoDetailViewProvider>(context, listen: true);
    return Sizer(builder: (context, Orientation, DeviceType) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
              child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 10.h,
                  child: Text(_pleaseSelectDate, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: font_size_16)),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 20.h,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      // Initial Value
                      value: woDetailViewProvider.secilenSure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: _labelDate,
                      ),

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: dataListSure.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          woDetailViewProvider.setSureDegeri = newValue.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
              woDetailViewProvider.secilenSure == 'Serbest Seçim'
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    // Initial Value
                                    value: woDetailViewProvider.secilenGun,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      labelText: 'Gün',
                                    ),

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: dataListGun.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        woDetailViewProvider.setSecilenGun = newValue.toString();
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    // Initial Value
                                    value: woDetailViewProvider.secilenSaat,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      labelText: 'Saat',
                                    ),

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: dataListSaat.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        woDetailViewProvider.setSecilenSaat = newValue.toString();
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    // Initial Value
                                    value: woDetailViewProvider.secilenDakika,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      labelText: 'Dakika',
                                    ),

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: dataListDakika.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        woDetailViewProvider.setSecilenDakika = newValue.toString();
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Text(''),
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
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                ),
                              ),
                              onPressed: () {
                                woDetailViewProvider.setSureDegeri = 'Lütfen Süre Seçiniz';
                                woDetailViewProvider.setSecilenGun = '1';
                                woDetailViewProvider.setSecilenSaat = '1';
                                woDetailViewProvider.setSecilenDakika = '1';
                              },
                              child: (const Text('Vazgeç')),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: APPColors.Login.blue,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                                ),
                              ),
                              onPressed: () {
                                String workPeriod = '';
                                if (woDetailViewProvider.secilenSure == 'Lütfen Süre Seçiniz') {
                                  snackBar(context, 'Süre seçmeden efor oluşturamazsınız', 'info');
                                } else {
                                  if (woDetailViewProvider.secilenSure == 'Serbest Seçim') {
                                    String dayValue = '';
                                    String saatValue = '';
                                    String dakikaValue = '';
                                    //Gun degeri
                                    if (woDetailViewProvider.secilenGun.length == 1) {
                                      dayValue = '00${woDetailViewProvider.secilenGun}';
                                    } else if (woDetailViewProvider.secilenGun.length == 2) {
                                      dayValue = '0${woDetailViewProvider.secilenGun}';
                                    } else if (woDetailViewProvider.secilenGun.length == 3) {
                                      dayValue = woDetailViewProvider.secilenGun;
                                    }

                                    //Saat degeri
                                    if (woDetailViewProvider.secilenSaat.length == 1) {
                                      saatValue = '0${woDetailViewProvider.secilenSaat}';
                                    } else if (woDetailViewProvider.secilenSaat.length == 2) {
                                      saatValue = woDetailViewProvider.secilenSaat;
                                    }

                                    //Dakika degeri
                                    if (woDetailViewProvider.secilenDakika.length == 1) {
                                      dakikaValue = '0${woDetailViewProvider.secilenDakika}';
                                    } else if (woDetailViewProvider.secilenDakika.length == 2) {
                                      dakikaValue = woDetailViewProvider.secilenDakika;
                                    }

                                    workPeriod = '$dayValue$saatValue${dakikaValue}00';
                                  } else {
                                    if (woDetailViewProvider.secilenSure == '15 dk') {
                                      workPeriod = '000001500';
                                    } else if (woDetailViewProvider.secilenSure == '30 dk') {
                                      workPeriod = '000003000';
                                    } else if (woDetailViewProvider.secilenSure == '45 dk') {
                                      workPeriod = '000004500';
                                    } else if (woDetailViewProvider.secilenSure == '1 sa') {
                                      workPeriod = '000010000';
                                    } else if (woDetailViewProvider.secilenSure == '2 sa') {
                                      workPeriod = '000020000';
                                    } else if (woDetailViewProvider.secilenSure == '6 sa') {
                                      workPeriod = '000060000';
                                    }
                                  }

                                  woDetailViewProvider.addEffort(context, widget.woCode, workPeriod);
                                }
                              },
                              child: const Text('Oluştur'),
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

