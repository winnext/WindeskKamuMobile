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
    List<String> dataListUrunler = ['Lütfen Ürün Seçiniz'];
    if (woDetailViewProvider.depoUrunlerArray[1].length > 0) {
      dataListUrunler = woDetailViewProvider.depoUrunlerArray[1];
    }
    List<String> dataListBirimler = ['Lütfen Birim Seçiniz'];
    if (woDetailViewProvider.depoBirimlerArray.length > 0) {
      dataListBirimler = woDetailViewProvider.depoBirimlerArray[1];
    }

    print('dataListDepo : ');
    print(dataListDepo);

    print('dataListUrunler : ');
    print(dataListUrunler);
    TextEditingController controllerMalzeme = TextEditingController();

    return Sizer(builder: (context, Orientation, DeviceType) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
            child: Column(
          children: [
            Expanded(
              child: SizedBox(
                  height: 10.h,
                  child: Text(
                    'Depo Seçimi.',
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
                    value: woDetailViewProvider.secilenDepo,
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
                        woDetailViewProvider.setSecilenDepoUrunSecimi =
                            'Lütfen Ürün Seçiniz';
                        woDetailViewProvider.getProducts(valueDegeri);
                      });

                      print(woDetailViewProvider.secilenDepo);
                    },
                  ),
                ),
              ),
            ),
            woDetailViewProvider.secilenDepo != 'Lütfen Depo Seçiniz'
                ? Expanded(
                    child: SizedBox(
                      height: 30.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          isExpanded: true,

                          // Initial Value
                          value: 'Lütfen Ürün Seçiniz',
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
                            print(
                                'SEÇİLEN DEGER URUN : ' + newValue.toString());
                            setState(() {
                              woDetailViewProvider.setSecilenDepoUrunSecimi =
                                  newValue.toString();

                              String valueDegeriUrun = woDetailViewProvider
                                      .depoUrunlerArray[0][
                                  dataListUrunler.indexOf(newValue.toString())];

                              print('SECİLEN DEGER URUN VALUE DEGERİ' +
                                  valueDegeriUrun);

                              woDetailViewProvider.setSecilenDepoUrunValue =
                                  valueDegeriUrun;

                              woDetailViewProvider.getBirimler(valueDegeriUrun);
                            });

                            print(woDetailViewProvider.secilenDepo);
                          },
                        ),
                      ),
                    ),
                  )
                : Text(''),
            woDetailViewProvider.secilenDepoUrunSecimi != 'Lütfen Ürün Seçiniz'
                ? Expanded(
                    child: SizedBox(
                      height: 30.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          isExpanded: true,

                          // Initial Value
                          value: "Lütfen Birim Seçiniz",
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelText: 'Birim Seçimi',
                          ),

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: dataListBirimler.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            print(
                                'SEÇİLEN DEGER BİRİM : ' + newValue.toString());
                            setState(() {
                              woDetailViewProvider.setSecilenBirim =
                                  newValue.toString();

                              String valueDegeriBirim =
                                  woDetailViewProvider.depoBirimlerArray[0][
                                      dataListBirimler
                                          .indexOf(newValue.toString())];

                              print('SECİLEN DEGER BİRİM VALUE DEGERİ' +
                                  valueDegeriBirim);

                              woDetailViewProvider.setSecilenBirimValue =
                                  valueDegeriBirim;

                              //woDetailViewProvider.getBirimler(valueDegeriUrun);
                            });

                            print('Seçilen birim : ' +
                                woDetailViewProvider.secilenBirim);
                          },
                        ),
                      ),
                    ),
                  )
                : Text(''),
            woDetailViewProvider.secilenBirim != 'Lütfen Birim Seçiniz'
                ? Expanded(
                    child: SizedBox(
                      height: 30.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controllerMalzeme,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelText: 'Miktar',
                          ),
                          onChanged: (inputValue) {},
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
                              if (woDetailViewProvider.secilenBirimValue !=
                                      '' &&
                                  woDetailViewProvider.secilenDepoUrunValue !=
                                      '' &&
                                  woDetailViewProvider.secilenDepoValue != '' &&
                                  controllerMalzeme.text != '') {
                                woDetailViewProvider.woAddMaterial(
                                    context,
                                    woDetailViewProvider.secilenDepoUrunValue,
                                    controllerMalzeme.text,
                                    woDetailViewProvider.secilenBirimValue);
                              } else {
                                print(woDetailViewProvider.secilenBirimValue);
                                print(
                                    woDetailViewProvider.secilenDepoUrunValue);
                                print(woDetailViewProvider.secilenDepoValue);
                                print(controllerMalzeme.text);

                                snackBar(context,
                                    'Lütfen boş alan bırakmayınız. ', 'error');
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

