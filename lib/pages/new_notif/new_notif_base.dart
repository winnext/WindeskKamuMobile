import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/widgets/customCalendar.dart';
import 'package:win_kamu/widgets/input.dart/buttonDropDown.dart';

import '../../l10n/locale_keys.g.dart';
import '../../providers/login_provider.dart';
import '../../providers/main_page_view_provider.dart';
import '../../providers/new_notif_provider.dart';
import '../../utils/themes.dart';
import '../../widgets/cardWidgets/customCardWithImageSmall.dart';
import '../../widgets/customDropdown.dart';
import '../../widgets/textfieldsWidgets/customTextArea.dart';
import '../full_screen_modal/full_screen_modal.dart';

class NewNotifBase  extends StatefulWidget {

  const NewNotifBase({super.key, required this.sayfa});
  final String sayfa;

  @override
  State<NewNotifBase> createState() => _NewNotifBaseState();
}

class _NewNotifBaseState extends State<NewNotifBase> {

    @override
  void initState() {
    super.initState();
    final nProvider = Provider.of<NewNotifProvider>(context, listen: false);
    


  }



  @override
  Widget build(BuildContext context) {
     final mainViewProvide = Provider.of<MainPageViewProvider>(context);
        int index = mainViewProvide.currentIndex;

      final nProvider = Provider.of<NewNotifProvider>(context, listen: true);
     // nProvider.clear = 1;
     var photos = nProvider.photos;
     var bases = nProvider.b64s;
     
     

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
  return new TakePictureScreen(camera: firstCamera,sayfa:'Yeni İş Emri',);
}));


    // print the data returned by the modal if any
  }

        
    return Sizer(      builder: (context, orientation, deviceType) {

      return Container(
      child:  Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: APPColors.Accent.blue,
            title: Text(widget.sayfa),
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
                                      controller: nProvider.mahal,
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
                                nProvider.scanQR();
                              },
                            ),
                            ),
                            Container( 
                            width: 10.w, 
                            child: 
                            IconButton(
                              icon: const Icon(Icons.qr_code),
                              onPressed: () {
                                nProvider.scanQR();

                              },
                            ),
                            ),
  

                           ],
                         ),
                         
                                
                            CupertinoTextField(
      decoration: BoxDecoration(
        color: APPColors.NewNotifi.grey,
        border: Border.all(color: Color.fromARGB(255, 235, 235, 235)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      controller: nProvider.aciklama,
      placeholder: 'Açıklama',
      placeholderStyle: TextStyle(color: Colors.black,),
      minLines: 3,
      maxLines: 6,
      style: TextStyle(color: Colors.black),
    ),
                            
                             TextField(          
                                                     
                                      controller: nProvider.arayan_num,
                                      decoration: 
                                      InputDecoration(
                                          hintText: 'Arayan Numara',
                                           hintStyle: TextStyle(
                                            color: Colors.black
                                          )
                                        ),
                                        
                                ),
                                Center(
                child: Container(
                  height: 10.h,
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
            nProvider.deletePhotos = index;
            nProvider.deleteB64 = index;

           
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

                         photos.length >= 6 ? (Container()) : (

                        Container(
                          width: 30.w,
                          height: 5.h,
                          child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: APPColors.Login.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          _showModal(context);

                        },
                        child: Icon(Icons.camera),
                      ),
                        )
                         ),

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
                          nProvider.clear = 1;
                        },
                        child: Text('Vazgeç'),
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
                        child: Text('Kaydet'),
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

