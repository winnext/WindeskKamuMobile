import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/providers/WoProviders/work_order_view_provider.dart';

import '../../providers/main_page_view_provider.dart';
import '../../utils/themes.dart';
import '../full_screen_modal/wo_full_screen_modal.dart';

class WoCreate extends StatefulWidget {
  const WoCreate({super.key});

  @override
  State<WoCreate> createState() => _WoCreateState();
}

class _WoCreateState extends State<WoCreate> {
  
  @override
  Widget build(BuildContext context) {
         final mainViewProvide = Provider.of<MainPageViewProvider>(context);

      final woProvider = Provider.of<WorkOrderProvider>(context, listen: true);
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
}));


    // print the data returned by the modal if any
  }
     
    return Sizer(      builder: (context, orientation, deviceType) {

      return Container(
      child:  Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: APPColors.Accent.blue,
            title: Text('Yeni İş Emri'),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                 Navigator.popUntil(context, (route) => route.isFirst);


                },
                icon: const Icon(  Icons.arrow_back )
                ),
            actions: [],
          ),
          body: Column(
            children: [
             
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(5),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      color: APPColors.NewNotifi.red,
                      height:5.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(mainViewProvide.kadi),
                          Text('date'),
                          Text('time')
                        ],
                      ),
                    ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Container(
                       height: 56.h,
                       child: Column(
                         children: [
                         Row(
                           children: [
                             Container(
                               width: 65.w,
                               child: 
                               TextField(                                 
                                      controller: woProvider.mahal,
                                      decoration: 
                                      InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Mahal',
                                          hintStyle: TextStyle(
                                            color: Colors.black
                                          )
                                          
                                          

                                        ),
                                        
                                ),
                             ),
                          Container( 
                            width: 10.w, 
                            child: 
                            IconButton(
                              icon: const Icon(Icons.barcode_reader),
                              onPressed: () {
                                woProvider.scanQR();
                              },
                            ),
                            ),
                            Container( 
                            width: 10.w, 
                            child: 
                            IconButton(
                              icon: const Icon(Icons.qr_code),
                              onPressed: () {
                                woProvider.scanQR();

                              },
                            ),
                            ),
  

                           ],
                         ),
                         
                                
                           
                            
                             TextField(          
                                                     
                                      controller: woProvider.arayan_num,
                                      decoration: 
                                      InputDecoration(
                                          hintText: 'Açıklama',
                                           hintStyle: TextStyle(
                                            color: Colors.black
                                          )
                                        ),
                                        
                                ),
                                  TextField(          
                                                     
                                      controller: woProvider.arayan_num,
                                      decoration: 
                                      InputDecoration(
                                          hintText: 'Varlık',
                                           hintStyle: TextStyle(
                                            color: Colors.black
                                          )
                                        ),
                                        
                                ),
                                Center(
                child: Container(
                  height: 30.h,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        
                        child: Column(
                          
                         children:[
                           ElevatedButton(
                             style: ElevatedButton.styleFrom(
              fixedSize: Size(30.w, 2.h), // specify width, height
    primary: Colors.red, // background
    onPrimary: Colors.white, // foreground
    
  ),
  onPressed: () { 
            woProvider.deletePhotos = index;
            woProvider.deleteB64 = index;

           
  },
  child: Icon(size:5.w,Icons.delete),
),
                           Container(
                             height: 13.h,
                             child: Image.file(File(photos[index])),
                           )
                         ],
                        ),
                      );
                    }
                  )
                ),
              ),
                              

                             
                           


                         ],

                   
                       ),
                     ),
                   ),
                  
                   Container(
                     height: 15.h,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [

                        

                         Container(
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
                          
                        },
                        child: Text('Oluştur'),
                      ),
                               ),
                               
                            ],
                          )
                        ),

                        
                         
                         
                       ],
                     ),
                   )
                  ],
                ),
              ),
            ],
            
          )
          ),
    );
    }
    );
  }
}