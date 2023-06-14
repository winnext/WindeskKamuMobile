import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/providers/search_view_provider.dart';
import 'package:win_kamu/providers/work_order_view_provider.dart';
import 'package:win_kamu/providers/workorder_detail_provider.dart';
import 'package:win_kamu/utils/global_utils.dart';

import '../../models/woListView.model.dart';
import '../../providers/login_provider.dart';
import '../../utils/themes.dart';
import '../WorkOrder/woDetail.dart';

class isEmriArama extends StatefulWidget {
  const isEmriArama({super.key});

  @override
  State<isEmriArama> createState() => _isEmriAramaState();
}

class _isEmriAramaState extends State<isEmriArama> {
  @override
  Widget build(BuildContext context) {
        final searchProvider = Provider.of<SearchViewProvider>(context);
        

     TextEditingController isEmriController = TextEditingController();
  var isEmriNo  = 0;


    return Sizer(      builder: (context, orientation, deviceType) {
    
    return Container(
      child:  Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('İş Emri Arama',style: TextStyle(color: Colors.black),),
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
                    controller: searchProvider.isEmriNo,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
                labelText: 'İş Emri',
              ),
                onChanged: (inputValue){
                  print(searchProvider.isEmriNo.text);
          if(searchProvider.vakaNo.text == ''){
            isEmriNo = 0;
          
            searchProvider.setVakaButonVisible = false;
            
          } else{
            isEmriNo =  1;
                        searchProvider.setVakaButonVisible = true;
           
            }
        },
               
             
            ),
            searchProvider.isEmriNo.text != ''  ?
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
                            onPressed: () async{
                              print('İşEmri NO : '+searchProvider.isEmriNo.text);
                              final woProvider = Provider.of<WorkOrderViewProvider>(context,listen: false);
                              String sonuc = await woProvider.checkWorkorderByAuthorizedServices('', searchProvider.isEmriNo.text);
                              print('İÇ  : '+sonuc.toString());
                              if(int.parse(sonuc) >  0){

                                final detailViewProvider = Provider.of<WoDetailViewProvider>(context,listen: false);

                              detailViewProvider.setwoCode = '';
                                            detailViewProvider.setwoCode = searchProvider.isEmriNo.text;
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => WoDetail(
                                                  moduleCode:
                                                      '',
                                                  woCode: searchProvider.isEmriNo.text
                                                ),
                                              ),
                                            );

                              }else if(int.parse(sonuc) == 0){
                                snackBar(context, 'İş emrini görmeye yetkiniz yoktur', 'info');

                              }else{
                                snackBar(context, 'Lütfen İş Emri Numarasını Kontrol Ediniz', 'info');
                              }
                              
                              
                              
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