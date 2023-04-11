import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/utils/global_utils.dart';

class NewNotifProvider  extends ChangeNotifier {
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