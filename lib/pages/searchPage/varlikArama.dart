import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:never_behind_keyboard/never_behind_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/providers/search_view_provider.dart';

import '../../providers/login_provider.dart';
import '../../utils/themes.dart';

class varlikArama extends StatefulWidget {
  const varlikArama({super.key});


  @override
  State<varlikArama> createState() => _varlikAramaState();
}

class _varlikAramaState extends State<varlikArama> {
    final globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
        final searchProvider = Provider.of<SearchViewProvider>(context);

     TextEditingController vakaNoController = TextEditingController();
  var vakaNo  = 0;

ScrollController _scrollController = ScrollController();
    print(_scrollController);
    return Sizer(      builder: (context, orientation, deviceType) {
    
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child:  Scaffold(
        resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Varlık Arama',style: TextStyle(color: Colors.black),),
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
                      controller: searchProvider.varliKodu,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Varlık Kodu',
                                ),
                                  onChanged: (inputValue){
                    print(searchProvider.varliKodu.text);
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
        searchProvider.scanBarcodeNormal('setVarlikKodu');
        FocusScope.of(context).requestFocus(FocusNode());
        // Your codes...
      },
    ),
  ],
),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
  alignment: Alignment.centerRight,
  children: <Widget>[
   TextField(
                      controller: searchProvider.seriNo,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Seri No',
                                ),
                                  onChanged: (inputValue){
                    print(searchProvider.seriNo.text);
                            if(searchProvider.seriNo.text == ''){
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
                searchProvider.scanBarcodeNormal('setSeriNo');

        FocusScope.of(context).requestFocus(FocusNode());
        // Your codes...
      },
    ),
  ],
),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
  alignment: Alignment.centerRight,
  children: <Widget>[
   TextField(
                      controller: searchProvider.rfid,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'RFID',
                                ),
                                  onChanged: (inputValue){
                    print(searchProvider.rfid.text);
                            if(searchProvider.rfid.text == ''){
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
                searchProvider.scanBarcodeNormal('setRfid');

        FocusScope.of(context).requestFocus(FocusNode());
        // Your codes...
      },
    ),
  ],
),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
  alignment: Alignment.centerRight,
  children: <Widget>[
   TextField(
                      controller: searchProvider.mahal,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Mahal',
                                ),
                                  onChanged: (inputValue){
                    print(searchProvider.mahal.text);
                            if(searchProvider.mahal.text == ''){
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
                searchProvider.scanBarcodeNormal('setMahal');

        FocusScope.of(context).requestFocus(FocusNode());
        // Your codes...
      },
    ),
  ],
),
                  ),
            searchProvider.varliKodu.text != '' || searchProvider.seriNo.text != '' || searchProvider.rfid.text != '' || searchProvider.mahal.text != '' ?
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

                             searchProvider.setVarlikKodu = '';
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