// ignore_for_file: prefer_final_fields, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:win_kamu/api/api_repository.dart';

class NewNotifProvider extends ChangeNotifier {
  final apirepository = APIRepository();

  String _qrCode = '';
  String _entityCode = '';
  String _serialNumber = '';
  String _rfid = '';
  String _locCode = '';
  String _imagePath = '';
  String _base64 = '';
  String get qrCode => _qrCode;

  String get imagePath => _imagePath;
  set setimagePath(String imagePath) {
    _imagePath = imagePath;
    notifyListeners();
  }

  String get base64 => _base64;
  set setbase64(String base64) {
    _base64 = base64;
    notifyListeners();
  }

  set setqrCode(String qrCode) {
    _qrCode = qrCode;
    notifyListeners();
  }

  String get entityCode => _entityCode;
  set setentityCode(String entityCode) {
    _entityCode = entityCode;
    notifyListeners();
  }

  String get serialNumber => _serialNumber;
  set setserialNumber(String serialNumber) {
    _serialNumber = serialNumber;
    notifyListeners();
  }

  String get rfid => _rfid;
  set setrfid(String rfid) {
    _rfid = rfid;
    notifyListeners();
  }

  String get locCode => _locCode;
  set setlocCode(String locCode) {
    _locCode = locCode;
    notifyListeners();
  }

  final _mahal = TextEditingController();
  TextEditingController get mahal => _mahal;
  set setMahal(String mahal) {
    _mahal.text = mahal;
    notifyListeners();
  }

  final _aciklama = TextEditingController();
  TextEditingController get aciklama => _aciklama;
  set setAciklama(String aciklama) {
    _aciklama.text = aciklama;
    notifyListeners();
  }

  final _arayan_num = TextEditingController();
  TextEditingController get arayan_num => _arayan_num;
  set setArayanNum(String arayan_num) {
    _arayan_num.text = arayan_num;
    notifyListeners();
  }

  List _photos = [];
  List get photos => _photos;

  set setPhotos(String photosx) {
    _photos.add(photosx);
    notifyListeners();
  }

  set deletePhotos(index) {
    _photos.removeAt(index);
    notifyListeners();
  }

  final _b64s = [];
  get b64s => _b64s;

  set setB64(b64x) {
    _b64s.add(b64x);
    notifyListeners();
  }

  set deleteB64(index) {
    _b64s.removeAt(index);
    notifyListeners();
  }

  set clear(index) {
    if (_mahal.text != '') {
      _mahal.text = '';
    }
    if (_aciklama.text != '') {
      _aciklama.text = '';
    }
    if (_arayan_num.text != '') {
      _arayan_num.text = '';
    }
    if (_photos.length != 0) {
      _photos.clear();
    }
    if (_b64s.length != 0) {
      _b64s.clear();
    }
    notifyListeners();
  }

  Future<void> scanQR(qrtype) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'İptal', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (barcodeScanRes != '-1') {
      print('object$barcodeScanRes');
      setqrCode = '';
      setentityCode = '';
      setlocCode = '';
      setrfid = '';
      setserialNumber = '';
      setMahal = barcodeScanRes;
      setqrCode = barcodeScanRes;

      qrtype == 'entityCode'
          ? setentityCode = barcodeScanRes.toString()
          : qrtype == 'serialNumber'
              ? setserialNumber = barcodeScanRes.toString()
              : qrtype == 'rfid'
                  ? setrfid = barcodeScanRes.toString()
                  : setlocCode = barcodeScanRes.toString();
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'İptal', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (barcodeScanRes != '-1') {
      setMahal = barcodeScanRes;
    }
  }
}
