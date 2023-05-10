import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/providers/search_view_provider.dart';

import '../../providers/login_provider.dart';
import '../../utils/themes.dart';

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
  var vakaNo  = 0;


    return Sizer(      builder: (context, orientation, deviceType) {
    
    return Container(
      child:  Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Vaka-(SLA) Arama',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            
            actions: [],
          ),
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
                onChanged: (inputValue){
                  print(searchProvider.vakaNo.text);
          if(searchProvider.vakaNo.text == ''){
            vakaNo = 0;
          
            searchProvider.setVakaButonVisible = false;
            
          } else{
            vakaNo =  1;
                        searchProvider.setVakaButonVisible = true;
           
            }
        },
               
             
            ),
            searchProvider.vakaNo.text != ''  ?
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
                                borderRadius:
                                    BorderRadius.circular(20), // <-- Radius
                              ),
                            ),
                            onPressed: () {

                              print(vakaNoController.text);
                              
                            },
                            child: const Text('Ara'),
                          ),
                        ),
            ),
            
                ],
              ),
            )
          )
          ),
    );
  }
    );
  }
}