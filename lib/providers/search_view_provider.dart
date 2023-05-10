import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/searchPage/mahalArama.dart';

import '../api/api_repository.dart';

class SearchViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();



        bool _vaka_buton_visible = false;
        bool  get vaka_buton_visible => _vaka_buton_visible;

        
     set setVakaButonVisible(bool vaka_buton_visible ){
        _vaka_buton_visible = vaka_buton_visible;
        notifyListeners();
      }  

          final _vakaNo = TextEditingController();

          TextEditingController get vakaNo => _vakaNo;

           set setVakaNo(String vakaNo) {
                _vakaNo.text = vakaNo;
                notifyListeners();
          }  


          final _varlikKodu = TextEditingController();

          TextEditingController get varliKodu => _varlikKodu;

           set setVarlikKodu(String varliKodu) {
                _varlikKodu.text = varliKodu;
                notifyListeners();
          }  

           final _seriNo = TextEditingController();

          TextEditingController get seriNo => _seriNo;

           set setSeriNo(String seriNo) {
                _seriNo.text = seriNo;
                notifyListeners();
          }  

          final _rfid = TextEditingController();

          TextEditingController get rfid => _rfid;

           set setRfid(String rfid) {
                _rfid.text = rfid;
                notifyListeners();
          }  

          final _mahal = TextEditingController();

          TextEditingController get mahal => _mahal;

           set setMahal(String mahal) {
                _mahal.text = mahal;
                notifyListeners();
          }


            final _mahalAramaMahalKodu = TextEditingController();

          TextEditingController get mahalAramaMahalKodu => _mahalAramaMahalKodu;

           set setMahalAramaMahalKodu(String mahalKodu) {
                _mahalAramaMahalKodu.text = mahalKodu;
                notifyListeners();
          }

           final _mahalAramaMahalAdi = TextEditingController();

          TextEditingController get mahalAramaMahalAdi => _mahalAramaMahalAdi;

           set setMahalAramaMahalAdi(String mahalAdi) {
                _mahalAramaMahalAdi.text = mahalAdi;
                notifyListeners();
          }

//////////////////////////////////////////////
/////////////////KAMPUS//////////////////////
////////////////////////////////////////////          

  List _mahalAraKampusArray = [];

         List get mahalAraKampusArray => _mahalAraKampusArray;
  set setMahalAraKampusArray(List mahalAraKampusArray) {
    _mahalAraKampusArray = mahalAraKampusArray;
    notifyListeners();
  }


    
mahalAramaKampusFetchData () async{
List <String> kampus = [];
List <String> kampusCode = [];

final mahalAramaKampusSonuc = await apirepository.mahalAramaKampus();
    for(var element in mahalAramaKampusSonuc){
     kampus.add(element['NAME'].toString());

}
for(var element in mahalAramaKampusSonuc){
    kampusCode.add(element['CODE'].toString());

}

    setMahalAraKampusArray = [kampus]+[kampusCode];
    notifyListeners();
  }


//////////////////////////////////////////////
/////////////////BINA////////////////////////
////////////////////////////////////////////

List _mahalAraBinaArray = [];

    List get mahalAraBinaArray => _mahalAraBinaArray;
set setMahalAraBinaArray(List mahalAraBinaArray) {
_mahalAraBinaArray = mahalAraBinaArray;
notifyListeners();
}


mahalAramaBinaFetchData (buildingCode) async{
List<String>  bina = [];
List<String> binaCode  = [];

final mahalAramaBinaSonuc = await apirepository.mahalAramaBina(buildingCode);
for(var element in mahalAramaBinaSonuc){
  bina.add(element['NAME'].toString());

}
for(var element in mahalAramaBinaSonuc){
    binaCode.add(element['CODE'].toString());

}

    //print(bina);
    setMahalAraBinaArray = [bina]+[binaCode];
    notifyListeners();
  }

//////////////////////////////////////////////
/////////////////KAT/////////////////////////
////////////////////////////////////////////

List _mahalAraKatArray = [];

    List get mahalAraKatArray => _mahalAraKatArray;
set setMahalAraKatArray(List mahalAraKatArray) {
_mahalAraKatArray = mahalAraKatArray;
notifyListeners();
}


mahalAramaKatFetchData (floorCode) async{
List <String> kat = [];
List <String> katCode = [];
final mahalAramaKatSonuc = await apirepository.mahalAramaKat(floorCode);
//print(mahalAramaKatSonuc);
for(var element in mahalAramaKatSonuc){
     kat.add(element['NAME'].toString());

}
for(var element in mahalAramaKatSonuc){
    katCode.add(element['CODE'].toString());

}
  // mahalAramaKatSonuc.map((i,element) {
  //       print(element);

  //   kat.add([mahalAramaKatSonuc[i]['NAME'].toString()]);
  //   kat.add([mahalAramaKatSonuc[i]['CODE'].toString()]);
  // } );
    

    //print([kat]+[katCode]);
    setMahalAraKatArray = [kat]+[katCode];
    notifyListeners();
  }


//////////////////////////////////////////////
/////////////////KANAT/////////////////////////
////////////////////////////////////////////

List _mahalAraKanatArray = [];

    List get mahalAraKanatArray => _mahalAraKanatArray;
set setMahalAraKanatArray(List mahalAraKanatArray) {
_mahalAraKanatArray = mahalAraKanatArray;
notifyListeners();
}


mahalAramaKanatFetchData (blockCode) async{
List <String> kanat = [];
List <String> kanatCode = [];
final mahalAramaKanatSonuc = await apirepository.mahalAramaKanat(blockCode);
//print(mahalAramaKatSonuc);
for(var element in mahalAramaKanatSonuc){
     kanat.add(element['NAME'].toString());

}
for(var element in mahalAramaKanatSonuc){
    kanatCode.add(element['CODE'].toString());

}
  // mahalAramaKatSonuc.map((i,element) {
  //       print(element);

  //   kat.add([mahalAramaKatSonuc[i]['NAME'].toString()]);
  //   kat.add([mahalAramaKatSonuc[i]['CODE'].toString()]);
  // } );
    

    //print([kat]+[katCode]);
    setMahalAraKanatArray = [kanat]+[kanatCode];
    notifyListeners();
  }



  



//////////////////////////////////////////////
/////////////////Sınıf/////////////////////////
////////////////////////////////////////////

List _mahalAraSinifArray = [];

    List get mahalAraSinifArray => _mahalAraSinifArray;
set setMahalAraSinifArray(List mahalAraSinifArray) {
_mahalAraSinifArray = mahalAraSinifArray;
notifyListeners();
}


mahalAramaSinifFetchData (blockCode) async{
List <String> sinif = [];
List <String> sinifCode = [];
final mahalAramaSinifSonuc = [
  {'NAME':'A','CODE':'A'},{'NAME':'B','CODE':'B'},{'NAME':'C','CODE':'C'},
  {'NAME':'D','CODE':'D'},{'NAME':'E','CODE':'E'}
 ];
//print(mahalAramaKatSonuc);
for(var element in mahalAramaSinifSonuc){
     sinif.add(element['NAME'].toString());

}
for(var element in mahalAramaSinifSonuc){
    sinifCode.add(element['CODE'].toString());

}
  // mahalAramaKatSonuc.map((i,element) {
  //       print(element);

  //   kat.add([mahalAramaKatSonuc[i]['NAME'].toString()]);
  //   kat.add([mahalAramaKatSonuc[i]['CODE'].toString()]);
  // } );
    

    //print([kat]+[katCode]);
    setMahalAraSinifArray = [sinif]+[sinifCode];
    notifyListeners();
  }










 Future<void> scanQR(setDurumu) async {
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
                  setDurumu = barcodeScanRes;
                }
      }

      // Platform messages are asynchronous, so we initialize in an async method.
      Future<void> scanBarcodeNormal(setDurumu) async {
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
                  if(setDurumu == 'setVarlikKodu'){
                    setVarlikKodu = barcodeScanRes;
                  }else if(setDurumu == 'setSeriNo'){
                    setSeriNo = barcodeScanRes;
                  }else if(setDurumu == 'setSeriNo'){
                    setSeriNo = barcodeScanRes;
                  }else if(setDurumu == 'setRfid'){
                    setRfid = barcodeScanRes;
                  }else if(setDurumu == 'setMahal'){
                    setMahal = barcodeScanRes;
                  }else if(setDurumu == 'setMahalAramaMahalKodu'){
                    setMahalAramaMahalKodu = barcodeScanRes;
                  }
                  
                }

      }





  
}
