import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/utils/global_utils.dart';

class WorkOrderViewProvider  extends ChangeNotifier {
    final apirepository = APIRepository();

  final _mahal = TextEditingController();
  TextEditingController get mahal => _mahal;
  set setMahal(String mahal){
    _mahal.text = mahal;
    notifyListeners();
  }

  final _aciklama = TextEditingController();
  TextEditingController get aciklama => _aciklama;
  set setAciklama(String aciklama){
    _aciklama.text = aciklama;
    notifyListeners();
  }

  final _varlik = TextEditingController();
  TextEditingController get varlik => _varlik;
  set setVarlik(String varlik){
    _varlik.text = varlik;
    notifyListeners();
  }

   final _arayan_num = TextEditingController();
  TextEditingController get arayan_num => _arayan_num;
  set setArayanNum(String arayan_num){
    _arayan_num.text = arayan_num;
    notifyListeners();
  }


  List _photos = [];
  List get photos => _photos;


  set setPhotos(String photosx){
    _photos.add(photosx);
    notifyListeners();

  }

  set deletePhotos(index){
    _photos.removeAt(index);
    notifyListeners();
  }

   

  final _b64s = [
   
  ];
  get b64s => _b64s;

  set setB64(b64x){
    _b64s.add(b64x);
    notifyListeners();

  }

  set deleteB64(index){
    _b64s.removeAt(index);
    notifyListeners();
  }


  set clear(index){
    if(_mahal.text != ''){
          _mahal.text = '';

    }
    if(_aciklama.text != ''){
          _aciklama.text = '';

    }
    if(_arayan_num.text != ''){
          _arayan_num.text = '';

    }
    if(_photos.length != 0){
          _photos.clear();

    }
    if(_b64s.length != 0){
          _b64s.clear();

    }
    notifyListeners();

  }
//////////////////////////////////////////////
///////////// Hizmet ////////////////////////
////////////////////////////////////////////  
List  _woCreateHizmetListeArray = [];

    List  get woCreateHizmetListeArray => _woCreateHizmetListeArray;
set setCreateWoHizmetListeArray(List  woCreateHizmetListeArray) {
_woCreateHizmetListeArray = woCreateHizmetListeArray;
notifyListeners();
}

String _woCreateHizmetValue = '';

    String get woCreateHizmetValue => _woCreateHizmetValue;
set setWoCreateHizmetValue(String woCreateHizmetValue) {
_woCreateHizmetValue = woCreateHizmetValue;
notifyListeners();
}



woCreateHizmetListesi(usercode ) async{
 List <String> name = ['Hizmet'];
List <String> code = ['Hizmet'];

final woCreateHizmetListesiSonuc = await apirepository.woCreateHizmetListesiApi(usercode);
print('sonuc : ');
print(woCreateHizmetListesiSonuc);
    for(var element in woCreateHizmetListesiSonuc){
      
     name.add(element['NAME'].toString());

}
for(var element in woCreateHizmetListesiSonuc){
    code.add(element['CODE'].toString());

}

    setCreateWoHizmetListeArray = [name]+[code];
    setWoCreateHizmetValue = woCreateHizmetValue != '' ? woCreateHizmetValue : name[0];
    notifyListeners();


}


//////////////////////////////////////////////
///////////// İş Emri Adı ////////////////////////
////////////////////////////////////////////  

List  _woCreateIsEmriAdiListeArray = [
  [
    'Teknik Onarım','Teknik Periyodik Bakım','Tıbbi Cihaz Kalibrasyonu','Teknik Periyodik Kontrol',
    'Tıbbi Cihaz Periyodik Kontrol','Tıbbi Cihaz Onarım','Periyodik Bakım','Önleyici Bakım','Görev İş Emri',
    'İç Denetim','İzleme İş Emirleri','Anlık Görev'
  
  ],
  [
    'accidental','planned','calibration','periodiccontrol','medicalperiodiccontrol','medicalaccidental'
    'periodic_maintenance','preventive_maintenance','task_workorder','internal_audit','watchingWorkorder'
    'reactive'  
  ]
  ];

    List  get woCreateIsEmriAdiListeArray => _woCreateIsEmriAdiListeArray;
set setWoCreateIsEmriAdiListeArray(List  woCreateIsEmriAdiListeArray) {
_woCreateIsEmriAdiListeArray = woCreateIsEmriAdiListeArray;
notifyListeners();
}

String _woCreateIsEmriAdiListeValue = '';

    String get woCreateIsEmriAdiListeValue => _woCreateIsEmriAdiListeValue;
set setWoCreateIsEmriAdiListeValue(String woCreateIsEmriAdiListeValue) {
_woCreateIsEmriAdiListeValue = woCreateIsEmriAdiListeValue;
notifyListeners();
}


//////////////////////////////////////////////
///////////// Öncelik ////////////////////////
////////////////////////////////////////////  

List  _woCreateOncelikListeArray = [
  [
    'Normal','Öncelikli','Acil'
  
  ],
  [
    '0','1','2'  
  ]
  ];

    List  get woCreateOncelikListeArray => _woCreateOncelikListeArray;
set setwoCreateOncelikListeArray(List  woCreateOncelikListeArray) {
_woCreateOncelikListeArray = woCreateOncelikListeArray;
notifyListeners();
}

String _woCreateOncelikListeValue = '';

    String get woCreateOncelikListeValue => _woCreateOncelikListeValue;
set setwoCreateOncelikListeValue(String woCreateOncelikListeValue) {
_woCreateOncelikListeValue = woCreateOncelikListeValue;
notifyListeners();
}

//////////////////////////////////////////////
///////////// WO Create /////////////////////
////////////////////////////////////////////  

showAlertDialog(BuildContext context, title, metin) {

  // set up the buttons
 showDialog(
  context: context,
  builder: (alertContext) => AlertDialog(
    title: Text(title.toString()),
    content: Text(metin),
    actions: [
       ElevatedButton(
        child: const Text("Tamam"),
        onPressed: () => Navigator.pop(alertContext),
      ),
       ElevatedButton(
        child: const Text("Detayı Gör"),
        onPressed: () => print('ROUTING WO DETAİL PAGE'),
      ),
    ],
  ),
);
}

woCreate(context ) async {

    String woSpace = mahal.text;
    print('WoSpace Mahal : '+woSpace);

    String woService = woCreateHizmetValue;
    print('Wo Service Hizmet Value : '+woService);

    String woName = woCreateIsEmriAdiListeValue;
    print('Wo Name İşEmriAdi Value : '+woName);

    String woNameLabel = woCreateIsEmriAdiListeValue;
    print('Wo Name Label İşEmriAdi : '+woNameLabel);

    String priority_type = woCreateOncelikListeValue;
    print('Oncelik Value: '+priority_type);

    String workorder_cfg = varlik.text;
    print('Varlik : '+workorder_cfg);

    String woDesc = aciklama.text;
    print('WoDesc : '+aciklama.text);

    var image = b64s;
    if(b64s.length > 0){
      image = b64s[0];
    }
    print('b64s length : '+b64s.length.toString());
    print('image  : ');
    print(image);


    if(woSpace != '' && woService != '' && woName != ''){
      woService = woCreateHizmetListeArray[1][woCreateHizmetListeArray[0].indexOf(woService)];
      woName = woCreateIsEmriAdiListeArray[1][woCreateIsEmriAdiListeArray[0].indexOf(woName)];
      if(woCreateOncelikListeArray[0].indexOf(priority_type) != -1){
              priority_type = woCreateOncelikListeArray[1][woCreateOncelikListeArray[0].indexOf(priority_type)];

      }else{
              priority_type = woCreateOncelikListeArray[1][0];

      }

      print('woservice val  : ');
      print(woService);

      print('woName val : ');
      print(woName);

      print('oncelik val  : ');
      print(priority_type);

      final woCreateSonuc = await apirepository.woCreate(woSpace, woService, woName, woNameLabel, priority_type, workorder_cfg, woDesc, image);
      print('sonucxx : ');
      print(woCreateSonuc);
      if(woCreateSonuc[0][0] == 0){
        snackBar(context, woCreateSonuc[1], 'hata');
      }else{
        snackBar(context, woCreateSonuc[1]['uyari'], 'success');
        
        setWoCreateHizmetValue = woCreateHizmetListeArray[0][0];
        setWoCreateIsEmriAdiListeValue = woCreateIsEmriAdiListeArray[0][0];
        setwoCreateOncelikListeValue = woCreateOncelikListeArray[0][0];

      
        clear = 1;
        setVarlik = '';
        showAlertDialog(context,'İş Emri Başarıyla Oluşturuldu',woCreateSonuc[1]['uyari']);
       



      }

    }else{
      snackBar(context, 'İş Emri tipi, tanımı ve mahali zorunludur', 'hata');
    }
    


    


} 

  
    

     Future<void> scanQR() async {
        String barcodeScanRes;
        // Platform messages may fail, so we use a try/catch PlatformException.
        try {
          barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'İptal', true, ScanMode.QR);
          print(barcodeScanRes);
        } on PlatformException {
          barcodeScanRes = 'Failed to get platform version.';
        }

        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.
        
          if(barcodeScanRes != '-1'){
                  setMahal = barcodeScanRes;
                }
      }

      // Platform messages are asynchronous, so we initialize in an async method.
      Future<void> scanBarcodeNormal() async {
        String barcodeScanRes;
        // Platform messages may fail, so we use a try/catch PlatformException.
        try {
          barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'İptal', true, ScanMode.BARCODE);
          print(barcodeScanRes);
        } on PlatformException {
          barcodeScanRes = 'Failed to get platform version.';
        }

        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.
                if(barcodeScanRes != '-1'){
                  setMahal = barcodeScanRes;
                }

      }

        


      
  
}