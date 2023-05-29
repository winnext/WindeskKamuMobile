import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/closedRequests/closedRequests.dart';
import 'package:win_kamu/providers/work_order_view_provider.dart';

import '../../providers/main_page_view_provider.dart';
import '../../utils/themes.dart';
import '../full_screen_modal/wo_full_screen_modal.dart';

class WoCreate extends StatefulWidget {
  const WoCreate({super.key});

  @override
  State<WoCreate> createState() => _WoCreateState();
}

class _WoCreateState extends State<WoCreate> {

  load() async{
    final mainViewProvide = Provider.of<MainPageViewProvider>(context,listen: false);

    final woProvider = Provider.of<WorkOrderViewProvider>(context,listen: false);
    
    await woProvider.woCreateHizmetListesi(mainViewProvide.kadi);
    print('data');
    print(woProvider.woCreateHizmetListeArray);
  }
  @override
  void initState() {
    // TODO: implement initState
    load();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
         final mainViewProvide = Provider.of<MainPageViewProvider>(context,listen: false);

      final woProvider = Provider.of<WorkOrderViewProvider>(context,listen: true);
     // nProvider.clear = 1;
     var photos = woProvider.photos;
     var bases = woProvider.b64s;

    dynamic _showModal(BuildContext context) async {
    // show the modal dialog and pass some data to it
    WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
    final results = await Navigator
    .of(context)
    .push(new MaterialPageRoute<dynamic>(builder: (BuildContext context) {
  return new TakePictureScreen(camera: firstCamera,sayfa: 'Yeni İş Emri',);
}
)
);



    // print the data returned by the modal if any
  }

 List<String> hizmet = woProvider.woCreateHizmetListeArray[0];
 List hizmetDatasi = woProvider.woCreateHizmetListeArray;

String dropdownvalueHizmet = hizmetDatasi[0].indexOf(woProvider.woCreateHizmetValue) != -1 ? woProvider.woCreateHizmetValue  : hizmet[0];    

print('dropdown');
print(dropdownvalueHizmet);


//////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
//////////////////////  İş Emri Adı     /////////////////////////
/////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////


 List<String> is_emri_adi = woProvider.woCreateIsEmriAdiListeArray[0];
 List is_emri_adi_datasi = woProvider.woCreateIsEmriAdiListeArray;

String dropdownvalueIsEmriAdi= is_emri_adi_datasi[0].indexOf(woProvider.woCreateIsEmriAdiListeValue) != -1 ? woProvider.woCreateIsEmriAdiListeValue  : is_emri_adi[0];    


print('dropdown İş Emri');
print(dropdownvalueIsEmriAdi);


//////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
//////////////////////  Öncelik     /////////////////////////
/////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////


 List<String> oncelik = woProvider.woCreateOncelikListeArray[0];
 List oncelik_datasi = woProvider.woCreateOncelikListeArray;

String dropdownvalueOncelik= oncelik_datasi[0].indexOf(woProvider.woCreateOncelikListeValue) != -1 ? woProvider.woCreateOncelikListeValue  : oncelik[0];    


print('dropdown İş Emri');
print(dropdownvalueIsEmriAdi);

  
    return Sizer(      builder: (context, orientation, deviceType) {

      return Container(
      child:  Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Yeni İş Emri',style: TextStyle(color: Colors.black),),
            centerTitle: true,
           
            actions: [],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 85.w,
          
              child: Column(
                children: [
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
  alignment: Alignment.centerRight,
  children: <Widget>[
   TextField(
                      controller: woProvider.mahal,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Mahal',
                                ),
                                  onChanged: (inputValue){
                    //print(searchProvider.varliKodu.text);
                          //   if(searchProvider.varliKodu.text == ''){
                          //     vakaNo = 0;
                            
                          //     searchProvider.setVakaButonVisible = false;
                              
                          //   } else{
                          //     vakaNo =  1;
                          // searchProvider.setVakaButonVisible = true;
                             
                          //     }
                          },
                                 
                               
                              ),
    IconButton(
      icon: Icon(Icons.qr_code_scanner),
      onPressed: () {
        woProvider.scanBarcodeNormal();
        FocusScope.of(context).requestFocus(FocusNode());
        // Your codes...
      },
    ),
  ],
),
                  ),

                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueHizmet,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Hizmet',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: hizmet.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: ( newValue) { 
                // setState(() {
                //   dropdownvalueBina = newValue!;
                // });
                 woProvider.setWoCreateHizmetValue = newValue!;

                // cek();
              },
            ),
                  ), 

            
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueIsEmriAdi,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'İş Emri Adı',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: is_emri_adi.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: ( newValue) { 
                // setState(() {
                //   dropdownvalueBina = newValue!;
                // });
                 woProvider.setWoCreateIsEmriAdiListeValue = newValue!;

                // cek();
              },
            ),
                  ), 


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                    controller: woProvider.aciklama,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
                labelText: 'Açıklama',
              ),
                onChanged: (inputValue){
                  //print(searchProvider.vakaNo.text);
          // if(searchProvider.vakaNo.text == ''){
          //   vakaNo = 0;
          
          //   searchProvider.setVakaButonVisible = false;
            
          // } else{
          //   vakaNo =  1;
          //               searchProvider.setVakaButonVisible = true;
           
          //   }
        },
               
             
            ),
                  ),

              Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueOncelik,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Öncelik',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: oncelik.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: ( newValue) { 
               
                   woProvider.setwoCreateOncelikListeValue = newValue!;

                // cek();
              },
            ),
                  ), 

                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                    controller: woProvider.varlik,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
                labelText: 'Varlık',
              ),
                onChanged: (inputValue){
                  //print(searchProvider.vakaNo.text);
          // if(searchProvider.vakaNo.text == ''){
          //   vakaNo = 0;
          
          //   searchProvider.setVakaButonVisible = false;
            
          // } else{
          //   vakaNo =  1;
          //               searchProvider.setVakaButonVisible = true;
           
          //   }
        },
               
             
            ),
                  ),
                    woProvider.photos.length > 0 ? 
                                                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 25.h,
                      width: 50.w,
                      child: Card(
                            
                            child: Column(
                              
                             children:[
                               ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                    fixedSize: Size(15.w, 2.h), // specify width, height
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white, // foreground
                                  
                                ),
                                onPressed: () { 
                                   woProvider.deletePhotos = 0;
                                   woProvider.deleteB64 = 0;
                              
                                 
                                },
                                child: Icon(size:5.w,Icons.delete),
                              ),
                               Container(
                                 height: 13.h,
                                 child: Image.file(File(photos[0])),
                               )
                             ],
                            ),
                          )
                    ),
                  ),
                  ) : Text(''),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 10),
                         child: Container(
                              width: 60.w,
                              height: 5.h,
                              child: Row(
                                children: [
                                   Container(
                                     width: 30.w,
                                     child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: APPColors.Login.red,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                      BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)
                                  ),
                              ),
                            ),
                            onPressed: () { 
                             photos.length > 0 ? woProvider.clear = 1 :  _showModal(context);
                            },
                            child: photos.length > 0 ? (Text('Vazgeç')) : (Icon(Icons.add_a_photo)),
                          ),
                                   ),
                       
                                   
                                   
                                    Container(
                                     width: 30.w,
                                     child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: APPColors.Login.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)
                                  ),
                                   
                              ),
                            ),
                            onPressed: () {
                              woProvider.woCreate(context);
                            },
                            child: Text('Oluştur'),
                          ),
                                   ),
                                   
                                ],
                              )
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