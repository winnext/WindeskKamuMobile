import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/pages/searchPage/mahalArama.dart';
import 'package:win_kamu/pages/searchPage/mahalAramaListe.dart';

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


  String _mahalAraKampusValue = '';

    String get mahalAraKampusValue => _mahalAraKampusValue;
set setmahalAraKampusValue(String mahalAraKampusValue) {
_mahalAraKampusValue = mahalAraKampusValue;
notifyListeners();
}


    
mahalAramaKampusFetchData () async{
List <String> kampus = ['Kampüs'];
List <String> kampusCode = ['Kampüs'];

final mahalAramaKampusSonuc = await apirepository.mahalAramaKampus();
print('sonuc : ');
print(mahalAramaKampusSonuc);
    for(var element in mahalAramaKampusSonuc){
      
     kampus.add(element['NAME'].toString());

}
for(var element in mahalAramaKampusSonuc){
    kampusCode.add(element['CODE'].toString());

}

    setMahalAraKampusArray = [kampus]+[kampusCode];
    setmahalAraKampusValue = mahalAraKampusValue != '' ? mahalAraKampusValue : kampus[0];
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

String _mahalAraBinaValue = '';

    String get mahalAraBinaValue => _mahalAraBinaValue;
set setmahalAraBinaValue(String mahalAraBinaValue) {
_mahalAraBinaValue = mahalAraBinaValue;
notifyListeners();
}


mahalAramaBinaFetchData (buildingCode) async{
List<String>  bina = ['Bina'];
List<String> binaCode  = ['Bina'];

final mahalAramaBinaSonuc = await apirepository.mahalAramaBina(buildingCode);
print(mahalAramaBinaSonuc);

for(var element in mahalAramaBinaSonuc){
  bina.add(element['NAME'].toString());

}
for(var element in mahalAramaBinaSonuc){
    binaCode.add(element['CODE'].toString());

}

    //print(bina);
    setMahalAraBinaArray = [bina]+[binaCode];
    setmahalAraBinaValue = mahalAraBinaValue != '' ? mahalAraBinaValue : bina[0];
    print('binakodları');
    print(binaCode);
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

String _mahalAraKatValue = '';

    String get mahalAraKatValue => _mahalAraKatValue;
set setMahalAraKatValue(String mahalAraKatValue) {
_mahalAraKatValue = mahalAraKatValue;
notifyListeners();
}


mahalAramaKatFetchData (floorCode) async{
List <String> kat = ['Kat'];
List <String> katCode = ['Kat'];
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
    print('MAHAL ARA KAT VALUE : '+mahalAraKatValue);
    setMahalAraKatValue = mahalAraKatValue != '' ? mahalAraKatValue : kat[0];
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


String _mahalAraKanatValue = '';

    String get mahalAraKanatValue => _mahalAraKanatValue;
set setMahalAraKanatValue(String mahalAraKanatValue) {
_mahalAraKanatValue = mahalAraKanatValue;
notifyListeners();
}


mahalAramaKanatFetchData (blockCode) async{
List <String> kanat = ['Kanat'];
List <String> kanatCode = ['Kanat'];
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
    setMahalAraKanatValue = mahalAraKanatValue != '' ? mahalAraKanatValue : kanat[0];
    notifyListeners();
  }



  



//////////////////////////////////////////////
/////////////////Sınıf/////////////////////////
////////////////////////////////////////////

List _mahalAraSinifArray = [['A','B'],['A','B']];

    List get mahalAraSinifArray => _mahalAraSinifArray;
set setMahalAraSinifArray(List mahalAraSinifArray) {
_mahalAraSinifArray = mahalAraSinifArray;
notifyListeners();
}

String _mahalAraSinifValue = '';

    String get mahalAraSinifValue => _mahalAraSinifValue;
set setMahalAraSinifValue(String mahalAraSinifValue) {
_mahalAraSinifValue = mahalAraSinifValue;
notifyListeners();
}


mahalAramaSinifFetchData (blockCode) async{
List <String> sinif = [];
List <String> sinifCode = [];
final mahalAramaSinifSonuc = [
{'NAME':'Sınıf','CODE':'Sınıf'},{'NAME':'A','CODE':'A'},{'NAME':'B','CODE':'B'},{'NAME':'C','CODE':'C'},
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
    setMahalAraSinifValue = mahalAraSinifValue != '' ? mahalAraSinifValue : sinif[0];

    
    notifyListeners();
  }



//////////////////////////////////////////////
////////////   Grup  /////////////////////////
////////////////////////////////////////////

List _mahalAraGrupArray = [];

    List get mahalAraGrupArray => _mahalAraGrupArray;
set setMahalAraGrupArray(List mahalAraGrupArray) {
_mahalAraGrupArray = mahalAraGrupArray;
notifyListeners();
}

String _mahalAraGrupValue = '';

    String get mahalAraGrupValue => _mahalAraGrupValue;
set setMahalAraGrupValue(String mahalAraGrupValue) {
 _mahalAraGrupValue = mahalAraGrupValue;
notifyListeners();
}


mahalAramaGrupFetchData () async{
List <String> grup = ['Grup'];
List <String> grupCode = ['Grup'];
final mahalAramaGrupSonuc = await apirepository.mahalAramaGrup();
//print(mahalAramaGrupSonuc);

for(var element in mahalAramaGrupSonuc){
  if(grup.indexOf(element['GROUP'].toString()) == -1 ){
         grup.add(element['GROUP'].toString());

  }

}
for(var element in mahalAramaGrupSonuc){
  if(grupCode.indexOf(element['CODE'].toString()) == -1 ){
        grupCode.add(element['CODE'].toString());

  }

}
  // mahalAramaKatSonuc.map((i,element) {
  //       print(element);

  //   kat.add([mahalAramaKatSonuc[i]['NAME'].toString()]);
  //   kat.add([mahalAramaKatSonuc[i]['CODE'].toString()]);
  // } );
    

    print([grup]+[grupCode]);
    setMahalAraGrupArray = [grup]+[grupCode];
    setMahalAraGrupValue = mahalAraGrupValue != '' ? mahalAraGrupValue : grup[0];
    notifyListeners();
  }

///////////////////////////////////////////////////////////////
/////////////////////////  MAHALLER LİSTESİ   //////////////////////////////
//////////////////////////////////////////////////////////////////


 String _sayfa = '1';
        String  get sayfa => _sayfa;

        
     set setSayfa(String sayfa ){
        _sayfa = sayfa;
        notifyListeners();
      }  

List _mahalAraListeArray = [];

    List get mahalAraListeArray => _mahalAraListeArray;
set setMahalAraListeArray(List mahalAraListeArray) {
_mahalAraListeArray = mahalAraListeArray;
notifyListeners();
}

mahalAramaListesi(mahalKodu, mahalAdi, bina, kat, kanat, sinif, grup, data, sayfa ) async{
  mahalAraListeArray.clear();
  final mahalAramaListesiSonuc = await apirepository.mahalAramaListesiApi(mahalKodu, mahalAdi, bina, kat, kanat, sinif, grup ,data, sayfa);
  print(mahalAramaListesiSonuc);
  setMahalAraListeArray = mahalAramaListesiSonuc;
      notifyListeners();


}


///////////////////////////////////////////////////////////////
/////////////////////////  MAHAL DETAY   ///////////////////////
////////////////////////////////////////////////////////////////








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
