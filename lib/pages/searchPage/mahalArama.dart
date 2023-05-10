import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:never_behind_keyboard/never_behind_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/closedRequests/closedRequests.dart';
import 'package:win_kamu/providers/search_view_provider.dart';

import '../../providers/login_provider.dart';
import '../../utils/themes.dart';

class mahalArama extends StatefulWidget {
  const mahalArama({super.key});


  @override
  State<mahalArama> createState() => _mahalAramaState();
}

class _mahalAramaState extends State<mahalArama> {
    final globalKey = new GlobalKey();
   
   List <String> kampus  = [];
   List <String> bina = [];
   List <String> kat = [];
   List <String> kanat = [];
   List <String> sinif = [];

   String dropdownvalueKampus  = '';
   String dropdownvalueBina = '';
   String dropdownvalueKat = '';
   String dropdownvalueKanat = '';
   String dropdownvalueSinif = '';

   

    


    @override
  void initState() {
    print('initState girdi');
        super.initState();

    // TODO: implement initState
        final searchProvider = Provider.of<SearchViewProvider>(context,listen: false);

        searchProvider.mahalAramaKampusFetchData();

    List <String> kampusS = searchProvider.mahalAraKampusArray[0];
    //print(searchProvider.mahalAraKampusArray);
    List kampusDatasi = searchProvider.mahalAraKampusArray;
  

    String dropdownvalueKampusS = kampusS[0] != '' ? kampusS[0] : '';   

    var secilen_deger_kampus = kampusDatasi[1][kampusDatasi[0].indexOf(dropdownvalueKampusS)];


    searchProvider.mahalAramaBinaFetchData(secilen_deger_kampus);
    //print(searchProvider.mahalAraBinaArray);
    List binaDatasi = searchProvider.mahalAraBinaArray;
    List <String> binaS = searchProvider.mahalAraBinaArray[0];


    String dropdownvalueBinaS= binaS[0];   
    var secilen_deger_bina = binaDatasi[1][binaDatasi[0].indexOf(dropdownvalueBinaS)];

      searchProvider.mahalAramaKatFetchData(secilen_deger_bina);
    //print(searchProvider.mahalAraKatArray[0]);

     List <String>  katS = searchProvider.mahalAraKatArray[0];
    List katDatasi = searchProvider.mahalAraKatArray;


    String dropdownvalueKatS= katS[0] != '' ? katS[0] : '';   

        var secilen_deger_kat = katDatasi[1][katDatasi[0].indexOf(dropdownvalueKatS)];

   searchProvider.mahalAramaKanatFetchData(secilen_deger_kat);

    List <String>  kanatS = searchProvider.mahalAraKanatArray[0];
    List kanatDatasi = searchProvider.mahalAraKanatArray;


    String dropdownvalueKanatS= kanatS[0] != '' ? kanatS[0] : '';   
    var secilen_deger_kanat = kanatDatasi[1][kanatDatasi[0].indexOf(dropdownvalueKanatS)];

     searchProvider.mahalAramaSinifFetchData(secilen_deger_kanat);
       List <String>  sinifS = searchProvider.mahalAraSinifArray[0];
    List sinifDatasi = searchProvider.mahalAraSinifArray;


    String dropdownvalueSinifS= sinifS[0] != '' ? sinifS[0] : '';   
    var secilen_deger_sinif = sinifDatasi[1][sinifDatasi[0].indexOf(dropdownvalueSinifS)];

  
    setState(() {
      List <String> kampus = kampusS;
      List <String> bina = binaS;
      List <String> kat = katS;
      List <String> kanat = kanatS;
      List <String> sinif = sinifS;

      String dropdownvalueKampus  = dropdownvalueKampusS;
      String dropdownvalueBina = dropdownvalueBinaS;
      String dropdownvalueKat = dropdownvalueKatS;
      String dropdownvalueKanat = dropdownvalueKanatS;
      String dropdownvalueSinif = dropdownvalueSinifS;



    });


  }
    

  

  @override
  Widget build(BuildContext context) {
      

        final searchProvider = Provider.of<SearchViewProvider>(context,listen: false);
    //searchProvider.mahalAramaKampusFetchData();
     TextEditingController vakaNoController = TextEditingController();
  var vakaNo  = 0;
        searchProvider.mahalAramaKampusFetchData();

    //print(_scrollController);

    List <String> kampus = searchProvider.mahalAraKampusArray[0];
    //print(searchProvider.mahalAraKampusArray);
    List kampusDatasi = searchProvider.mahalAraKampusArray;
  

    String dropdownvalueKampus = kampus[0] != '' ? kampus[0] : '';   

    var secilen_deger_kampus = kampusDatasi[1][kampusDatasi[0].indexOf(dropdownvalueKampus)];


    searchProvider.mahalAramaBinaFetchData(secilen_deger_kampus);
    //print(searchProvider.mahalAraBinaArray);
    List binaDatasi = searchProvider.mahalAraBinaArray;
    List <String> bina = searchProvider.mahalAraBinaArray[0];


    String dropdownvalueBina= bina[0];   
    var secilen_deger_bina = binaDatasi[1][binaDatasi[0].indexOf(dropdownvalueBina)];

      searchProvider.mahalAramaKatFetchData(secilen_deger_bina);
    //print(searchProvider.mahalAraKatArray[0]);

     List <String>  kat = searchProvider.mahalAraKatArray[0];
    List katDatasi = searchProvider.mahalAraKatArray;


    String dropdownvalueKat= kat[0] != '' ? kat[0] : '';   

        var secilen_deger_kat = katDatasi[1][katDatasi[0].indexOf(dropdownvalueKat)];

   searchProvider.mahalAramaKanatFetchData(secilen_deger_kat);

    List <String>  kanat = searchProvider.mahalAraKanatArray[0];
    List kanatDatasi = searchProvider.mahalAraKanatArray;


    String dropdownvalueKanat= kanat[0] != '' ? kanat[0] : '';   
    var secilen_deger_kanat = kanatDatasi[1][kanatDatasi[0].indexOf(dropdownvalueKanat)];

     searchProvider.mahalAramaSinifFetchData(secilen_deger_kanat);
       List <String>  sinif = searchProvider.mahalAraSinifArray[0];
    List sinifDatasi = searchProvider.mahalAraSinifArray;


    String dropdownvalueSinif= sinif[0] != '' ? sinif[0] : '';   
    var secilen_deger_sinif = sinifDatasi[1][sinifDatasi[0].indexOf(dropdownvalueSinif)];

  


    return Sizer(      builder: (context, orientation, deviceType) {
    
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child:  Scaffold(
        resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Mahal Arama',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            
            actions: [],
          ),
          body: 
          Center(
            child: SingleChildScrollView(
              child: Container(
              width: 85.w,
              
             
              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
  alignment: Alignment.centerRight,
  children: <Widget>[
   TextField(
                      controller: searchProvider.mahalAramaMahalKodu,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Mahal Kodu',
                                ),
                                  onChanged: (inputValue){
                    //print(searchProvider.varliKodu.text);
                            if(searchProvider.varliKodu.text == ''){
                              vakaNo = 0;
                            
                              searchProvider.setVakaButonVisible = false;
                              
                            } else{
                              vakaNo =  1;
                          searchProvider.setVakaButonVisible = true;
                             
                              }
                          },
                                 
                               
                              ),
    IconButton(
      icon: Icon(Icons.qr_code_scanner),
      onPressed: () {
        searchProvider.scanBarcodeNormal('setMahalAramaMahalKodu');
        FocusScope.of(context).requestFocus(FocusNode());
        // Your codes...
      },
    ),
  ],
),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                    controller: searchProvider.mahalAramaMahalAdi,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
                labelText: 'Mahal Adı',
              ),
                onChanged: (inputValue){
                  //print(searchProvider.vakaNo.text);
          if(searchProvider.vakaNo.text == ''){
            vakaNo = 0;
          
            searchProvider.setVakaButonVisible = false;
            
          } else{
            vakaNo =  1;
                        searchProvider.setVakaButonVisible = true;
           
            }
        },
               
             
            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueKampus,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Kampüs',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: kampus.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueKampus = newValue!;
                });
              },
            ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueBina,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Bina',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: bina.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueBina = newValue!;
                });
              },
            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueKat,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Kat',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: kat.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueKat = newValue!;
                });
              },
            ),
                  ),

                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueKanat,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Kanat',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: kanat.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueKanat = newValue!;
                });
              },
            ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueSinif,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Sınıf',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: sinif.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueSinif = newValue!;
                });
              },
            ),
                  ),
                  
                 
            searchProvider.mahalAramaMahalKodu.text != '' || searchProvider.mahalAramaMahalAdi.text != '' || searchProvider.rfid.text != '' || searchProvider.mahal.text != '' ?
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                          width: 45.w,
                          height: 8.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: APPColors.Main.red,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // <-- Radius
                              ),
                            ),
                            onPressed: () {

                             searchProvider.setMahalAramaMahalKodu = '';
                             searchProvider.setMahalAramaMahalAdi = '';
                             searchProvider.setSeriNo = '';
                             searchProvider.setRfid = '';
                             searchProvider.setMahal = '';



                              
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
                                borderRadius:
                                    BorderRadius.circular(20), // <-- Radius
                              ),
                            ),
                            onPressed: () {

                              print("Vaka NO : "+searchProvider.varliKodu.text);
                              print("Seri NO : "+searchProvider.seriNo.text);
                              print("RFID : "+searchProvider.rfid.text);
                              print("Mahal : "+searchProvider.mahal.text);


                              
                            },
                            child: const Text('Ara'),
                          ),
                        ),
            ),
            
                ],
              ),
            ),
            )
          )
          
          ),
    );
  }
    );
  }
}