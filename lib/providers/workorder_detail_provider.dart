// ignore_for_file: prefer_typing_uninitialized_variables, dead_code, avoid_print, prefer_interpolation_to_compose_strings, prefer_final_fields, unused_field

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/models/detail_activities.model.dart';
import 'package:win_kamu/models/issue_summary.modal.dart';
import 'package:win_kamu/utils/api_urls.dart';

import '../models/documants_model.dart';
import '../models/shiftings_model.dart';
import '../models/worelated_modal.dart';
import '../models/work_order_personals.dart';
import '../models/work_order_personals_detailed.dart';
import '../models/workoder_detail_modal.dart';
import '../utils/global_utils.dart';

class WoDetailViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();
  var data;

  List<WoDetailViewModel> _woDetailView = [];
  List<WoDetailViewModel> tempwoDetailView = [];

  List<WoRelatedViewModel> _woRelatedView = [];
  List<WoRelatedViewModel> tempwoRelatedView = [];

  List<WoDetailViewModel> queryParameters = [];

  List<DetailActivitiesModal> _listViewActivities = [];
  List<DetailActivitiesModal> tempListViewActivities = [];

  List<IssueSummaryModal> _issueSummary = [];
  List<IssueSummaryModal> tempIssueSummary = [];

  String? _responses;

  String? _woCode;
  bool _isDataLoading = true;
  bool _loading = false;
  bool _isDataExist = false;
  int _toplamKayitSayisi = 0;

  List<WoDetailViewModel> get woDetailView => _woDetailView;
  set setiwoDetailView(List<WoDetailViewModel> woDetailView) {
    _woDetailView = woDetailView;
    notifyListeners();
  }

  List<WoRelatedViewModel> get woRelatedView => _woRelatedView;
  set setiwoRelatedView(List<WoRelatedViewModel> woRelatedView) {
    _woRelatedView = woRelatedView;
    notifyListeners();
  }

  List<IssueSummaryModal> get issueSummary => _issueSummary;
  set setiissueSummary(List<IssueSummaryModal> issueSummary) {
    _issueSummary = issueSummary;
    notifyListeners();
  }

  List<DetailActivitiesModal> get listViewActivities => _listViewActivities;
  set setilistViewActivities(List<DetailActivitiesModal> listViewActivities) {
    _listViewActivities = listViewActivities;
    notifyListeners();
  }

  bool get isDataLoading => _isDataLoading;

  set setisDataLoading(bool isDataLoading) {
    _isDataLoading = isDataLoading;
    notifyListeners();
  }

  bool get loading => _loading;

  set setloading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  get woCode => _woCode;

  set setwoCode(String woCode) {
    _woCode = woCode;
    notifyListeners();
  }

  String _woDetailService = '';
  get woDetailService => _woDetailService;

  set setWoDetailService(String service) {
    _woDetailService = service;
    notifyListeners();
  }

  get responses => _responses;

  set setresponses(String responses) {
    _woCode = woCode;
    notifyListeners();
  }

  int get toplamKayitSayisi => _toplamKayitSayisi;

  set settoplamKayitSayisi(int toplamKayitSayisi) {
    _toplamKayitSayisi = toplamKayitSayisi;
    notifyListeners();
  }

  bool get isDataExist => _isDataExist;

  set setisDataExist(bool isDataExist) {
    _isDataExist = isDataExist;
    notifyListeners();
  }

  // wo_person functions and attributes
  List<ShiftingsModel> _shiftings = [];
  List<ShiftingsModel> get shiftings => _shiftings;

  List<WorkOrderPersonals> _workOrderPersonals = [];
  List<WorkOrderPersonals> get workOrderPersonals => _workOrderPersonals;

  List<WorkOrderPersonalsDetailed> _workOrderPersonalsDetailed = [];
  List<WorkOrderPersonalsDetailed> get workOrderPersonalsDetailed =>
      _workOrderPersonalsDetailed;

  String _pickedPersonalName = 'Personal ismi seçiniz';
  String get pickedPersonalName => _pickedPersonalName;

  String _pickShifting = 'Lütfen vardiya seçiniz';
  String get pickShifting => _pickShifting;

  bool _isNewPersonalAdded = false;
  bool get isNewPersonalAdded => _isNewPersonalAdded;

  set setisNewPersonalAdded(bool isNewPersonalAdded) {
    _isNewPersonalAdded = isNewPersonalAdded;
    notifyListeners();
  }

  set setPickShifting(String pickShifting) {
    _pickShifting = pickShifting;
  }

  set setPickedPersonalName(String pickedPersonalName) {
    _pickedPersonalName = pickedPersonalName;
  }

  loadAllPersonalsDetailed() async {
    _workOrderPersonalsDetailed = [];

    final data = await apirepository.getWorkOrderPersonelsApi(woCode);

    for (var item in data) {
      _workOrderPersonalsDetailed
          .add(WorkOrderPersonalsDetailed.fromJson(item));
    }

    notifyListeners();
  }

  loadAllPersonals() async {
    _workOrderPersonals = [];

    final data =
        await apirepository.getWorkOrderAddedPersonelsApi(12.toString());

    for (var item in data) {
      _workOrderPersonals.add(WorkOrderPersonals.fromJson(item));
    }

    notifyListeners();
  }

  loadShiftings() async {
    _shiftings = [];
    final data = await apirepository.getShiftings(woCode);
    print(data);

    for (var item in data) {
      _shiftings.add(ShiftingsModel.fromJson(item));
    }

    print(_shiftings.first.name);

    notifyListeners();
  }

  // camera functions and attributes for wo_detail
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  File? get image => _image != null ? _image! : null;

  set setImage(File? image) {
    _image = image;
    notifyListeners();
  }

  String _imageDesc = '';
  String get imageDesc => _imageDesc;
  set setImageDesc(String imageDesc) {
    _imageDesc = imageDesc;
    notifyListeners();
  }

  saveImage() async {
    if (_image != null) {
      Uint8List imagebytes = await _image!.readAsBytes(); //convert to bytes
      String base64string =
          base64.encode(imagebytes); //convert bytes to base64 string

      final response = await apirepository.woCreateFotoEkle(
          woCode, base64string, _imageDesc);

      if (response != null) {
        print("image eklendi");
      }
    } else {
      return;
    }
  }

  // pick documant functions and attributes for add_documant_sheet
  FilePickerResult? filePickerResult;

  String _pdfDesc = '';
  String get pdfDesc => _pdfDesc;
  set setPdfDesc(String pdfDesc) {
    _pdfDesc = pdfDesc;
  }

  String _pdfPath = '';
  String get pdfPath => _pdfPath;

  bool _isDocumantPicked = false;
  bool get isDocumantPicked => _isDocumantPicked;

  set setIsDocumantPicked(bool isDocumantPicked) {
    _isDocumantPicked = isDocumantPicked;
    notifyListeners();
  }

  Future pickDocumant() async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (filePickerResult != null) {
      _pdfPath = filePickerResult!.files.first.path ?? '';
      setIsDocumantPicked = true;
      print("pdf path : " + _pdfPath);
    }
  }

  saveDocumant() async {
    if (_pdfPath.isNotEmpty) {
      final bytes = File(_pdfPath).readAsBytesSync();
      String file64 = base64Encode(bytes);

      final response =
          await apirepository.woCreateFotoEkle(woCode, file64, _pdfDesc);

      if (response != null) {
        print("pdf eklendi");
      }
    } else {
      return;
    }
  }

  // fetch all files for wo_detail
  List<DocumantsModel> _documants = [];
  List<DocumantsModel> get documants => _documants;

  fetchFiles() async {
    _documants = [];
    final data = await apirepository.fetchFiles(woCode);

    print('response: ' + data.toString());

    for (var item in data) {
      print('item : ' + item.toString());
      _documants.add(DocumantsModel.fromJson(item));
    }

    print('First doc: ${_documants.first}');

    notifyListeners();
  }

  String getFilePath(String documantId) {
    return apirepository.getFilePath() + documantId;
  }

  loadWoDetail(String woCode, String xusercode) async {
    print('LoadWoDetail ');
    woDetailView.clear();

    _isDataLoading = true;

    final responseUrl = '$BASE_URL_V2/workorder/detail/$woCode';
    final data = await apirepository.getRequestDetail(
        controller: responseUrl, issueCode: woCode, xuserCode: xusercode);
    if (true) {
      Future.delayed(const Duration(milliseconds: 10), () {
        var responseData = WoDetailViewModel.fromJson(data.detail['detail']);
        woDetailView.add(responseData);
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
      print('STATUS : : :');
      print(woDetailView[0].STATUS);
      setWoDetailService = data.detail['SERVICE'];
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  addWorkOrderPersonal() async {
    String personalCode = _workOrderPersonals
            .firstWhere((element) => element.fullname == _pickedPersonalName)
            .code ??
        '';
    String shiftingCode = _shiftings
            .firstWhere((element) => element.name == _pickShifting)
            .code ??
        '';
    final data = await apirepository.addWorkOrderPersonal(
        woCode, personalCode, shiftingCode);

    if (data != null) {
      _isNewPersonalAdded = true;
      notifyListeners();
    }
  }

  deleteWorkOrderPersonal(String moduleCode) async {
    final data =
        await apirepository.deleteWorkOrderPersonal(moduleCode, woCode);

    if (data != null) {
      _isNewPersonalAdded = false;
      _workOrderPersonalsDetailed
          .removeWhere((element) => element.modulecode == moduleCode);
      notifyListeners();
    }
  }

  woGetRelatedSpace(String woCode, String xusercode) async {
    _isDataLoading = true;

    final responseUrl = '$BASE_URL_V2/workorder/$woCode/space';
    final data = await apirepository.woGetRelatedSpace(
        controller: responseUrl, xuserCode: xusercode);
    print('woReleatedd${data.records['records']}');

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        woRelatedView.clear();
        tempwoRelatedView = (data.records['records'] as List)
            .map((e) => WoRelatedViewModel.fromJson(e))
            .toList();
        woRelatedView.addAll(tempwoRelatedView);
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }
  // loadIssueSummary(String woCode, String xusercode) async {
  //   _isDataLoading = true;
  //   final responseUrl = BASE_URL_V2 + '/issue/${woCode}/summary';

  //   final data = await apirepository.getIssueSummary(
  //       controller: responseUrl, issueCode: woCode, xuserCode: xusercode);

  //   //print('issueDetail3 : ' + queryParameters.toString() + ' +++ ' + responseUrl.toString());

  //   if (true) {
  //     Future.delayed(const Duration(milliseconds: 0), () {
  //       var responseData = IssueSummaryModal.fromJson(data.detail['detail']);
  //       print('issueDetailll22' + responseData.toString());

  //       _issueSummary.add(responseData);
  //       _isDataLoading = false;
  //       _loading = false;
  //       _isDataExist = false;
  //       notifyListeners();
  //     });
  //   } else {
  //     // baglantiHatasi(context, result.message);
  //   }
  // }

  sendIssueActivity(String woCode, String userName, String activityCode,
      String imageDescription) async {
    if (imageDescription.toString().length < 20 &&
        activityCode.toString() == 'AR00000001336') {
      return 'Lütfen yeterli uzunlukta açıklama giriniz';
    } else {
      final apiresult = await apirepository.addIssueActivity(
          userName: userName,
          issueCode: woCode,
          activityCode: activityCode,
          description: imageDescription);

      final results = jsonDecode(apiresult.toString());

      print('activity inside 2 ${results['resultcode']}');

      if (results['success'].toString() == 'false') {
        //_responses = results['resultcode'];
        print('activityresponse${results['success']}');
        //notifyListeners();
        return 'Aktivite girişi başarısız';
      } else {
        return 'Aktivite girişi başarılı.';
      }
    }
  }

  //iş emri başlat

  woActualDateActions(type, code) async {
    final result = await apirepository.woActualDateActions(type, code);
  }

  // eforlar süre

  String _secilenSure = 'Lütfen Süre Seçiniz';

  String get secilenSure => _secilenSure;

  set setSureDegeri(String sureDegeri) {
    _secilenSure = sureDegeri;
  }

  //eforlar gun
  String _secilenGun = '0';

  String get secilenGun => _secilenGun;

  set setSecilenGun(String secilenGun) {
    _secilenGun = secilenGun;
    notifyListeners();
  }

  //eforlar saat
  String _secilenSaat = '1';
  String get secilenSaat => _secilenSaat;

  set setSecilenSaat(String secilenSaat) {
    _secilenSaat = secilenSaat;
    notifyListeners();
  }

  //eforlar dakika
  String _secilenDakika = '1';

  String get secilenDakika => _secilenDakika;

  set setSecilenDakika(String secilenDakika) {
    _secilenDakika = secilenDakika;
    notifyListeners();
  }

  // ADD EFFORT

  addEffort(context, code, workPeriod) async {
    print('WOCODE : ' + code);
    print('WORKPERIOD : ' + workPeriod);
    final result = await apirepository.addEffortApi(code, workPeriod);
    if (result == true) {
      snackBar(context, 'Efor başarıyla oluşturuldu ', 'success');
      Navigator.pop(context);
    } else {
      snackBar(context, 'Efor eklenirken hata oluştu ', 'error');
    }
    await getWorkOrderWorklogs(woCode);
    print(result);
  }

  //Delete Efforty
  deleteEffort(context, woLogCode, woCode) async {
    print('Silinecek Efor : ' + woLogCode.toString());
    final deleteEffortResult = await apirepository.deleteEffortApi(woLogCode);

    await getWorkOrderWorklogs(woCode);

    print(deleteEffortResult);
  }

  // Eforlar
  List _eforlarArray = [];

  List get eforlarArray => _eforlarArray;
  set setEforlarArray(List eforlarArray) {
    _eforlarArray = eforlarArray;
    notifyListeners();
  }

  getWorkOrderWorklogs(woCode) async {
    setEforlarArray = [];
    List<String> codes = [];
    List<String> users = [];
    List<String> timeworkeds = [];
    final result2 = await apirepository.getWorkOrderWorklogsApi(woCode);
    for (var element in result2) {
      codes.add(element['CODE']);
      users.add(element['USER']);
      // if(element['TIMEWORKED'] > 24.0){
      //   String gun = element['TIMEWORKED']%24;
      //   String saat = element['TIMEWORKED'];
      // }else{
      //   if(element['TIMEWORKED'] > 1.0){
      //     var dakika = element['TIMEWORKED']*60%60.toString();
      //     var saat = int.parse(element['TIMEWORKED']).toString();
      //     timeworkeds.add(saat+' sa'+dakika+' dk');

      //   }else{
      //       timeworkeds.add(element['TIMEWORKED']*60.toString()+' dk');

      //   }
      // }
      if (element['TIMEWORKED'] > 1) {
        timeworkeds.add('${element['TIMEWORKED'].toInt()} sa');
      } else {
        timeworkeds.add('${element['TIMEWORKED'] * 60} dk');
      }

      //timeworkeds.add('1 gun 1 sa 21 dk ');
    }
    setEforlarArray = [codes] + [users] + [timeworkeds];
  }

  //////////////////// MALZEMELER ////////////////////////////
  List _malzemelerArray = [];

  List get malzemelerArray => _malzemelerArray;
  set setMalzemelerArray(List malzemelerArray) {
    _malzemelerArray = malzemelerArray;
    notifyListeners();
  }

  getWorkorderSpareParts(woCode) async {
    setMalzemelerArray = [];
    List<String> codes = [];
    List<String> product_name = [];
    List<String> amount = [];
    List<String> unit = [];

    final result2 = await apirepository.getWorkorderSparepartsApi(woCode);
    print('Malzemeler datası');
    print(result2);
    for (var element in result2) {
      if (element['CODE'] != null &&
          element['PRODUCTNAME'] != null &&
          element['AMOUNT'] != null &&
          element['UNIT'] != null) {
        codes.add(element['CODE']);
        product_name.add(element['PRODUCTNAME']);
        amount.add(element['AMOUNT']);
        unit.add(element['UNIT']);
      }
    }
    setMalzemelerArray = [codes] + [product_name] + [amount] + [unit];
    print(malzemelerArray);
  }

  deleteSpareParts(context, code) async {
    print('Silinecek Malzeme : ' + code.toString());
    final deleteEffortResult = await apirepository.deleteSparepartsApi(code);
    if (deleteEffortResult == true) {
      snackBar(context, 'Malzeme başarıyla silindi ', 'success');

      await getWorkorderSpareParts(woCode);
    } else {
      snackBar(context, 'Malzeme silinirken bir hata oluştu ', 'error');
    }

    print(deleteEffortResult);
  }

////////////////////Malzeme seçimi  Depolar///////////////////
  String _secilenDepo = 'Lütfen Depo Seçiniz';

  String get secilenDepo => _secilenDepo;

  set setDepoDegeri(String depoDegeri) {
    _secilenDepo = depoDegeri;
    notifyListeners();
  }

  String _secilenDepoValue = '';

  String get secilenDepoValue => _secilenDepoValue;

  set setDepoDegeriValue(String depoDegeriValue) {
    _secilenDepoValue = depoDegeriValue;
    notifyListeners();
  }

  List _depolarArray = [];

  List get depolarArray => _depolarArray;
  set setDepolarArray(List depolarArray) {
    _depolarArray = depolarArray;
    notifyListeners();
  }

  getStore() async {
    setDepolarArray = [];
    final depolarSonuc = await apirepository.getStoreApi();
    print('depolar sonuc : ');
    print(depolarSonuc);
    List<String> codes = ['Lütfen Depo Seçiniz'];
    List<String> names = ['Lütfen Depo Seçiniz'];
    for (var element in depolarSonuc) {
      if (!names.contains(element['NAME']) && element['NAME'] != null) {
        codes.add(element['CODE']);
        names.add(element['NAME']);
      }
    }
    setDepolarArray = [codes] + [names];
    print('depolar array');
    print(depolarArray);
  }

//Malzeme seçimi  Ürün Seçimi
  String _secilenDepoUrunSecimi = 'Lütfen Ürün Seçiniz';

  String get secilenDepoUrunSecimi => _secilenDepoUrunSecimi;

  set setSecilenDepoUrunSecimi(String secilenDepoUrunSecimi) {
    _secilenDepoUrunSecimi = secilenDepoUrunSecimi;
    notifyListeners();
  }

  String _secilenDepoUrunValue = '';

  String get secilenDepoUrunValue => _secilenDepoUrunValue;

  set setSecilenDepoUrunValue(String secilenDepoUrunValue) {
    _secilenDepoUrunValue = secilenDepoUrunValue;
    notifyListeners();
  }

  List _depoUrunlerArray = [];

  List get depoUrunlerArray => _depoUrunlerArray;
  set setDepoUrunlerArray(List depoUrunlerArray) {
    _depoUrunlerArray = depoUrunlerArray;
    notifyListeners();
  }

  getProducts(depoKodu) async {
    setDepoUrunlerArray = [];
    final depoUrunlerSonuc = await apirepository.getProductsApi(depoKodu);
    print('depo urunler sonuc : ');
    print(depoUrunlerSonuc);
    List<String> codes = ['Lütfen Ürün Seçiniz'];
    List<String> names = ['Lütfen Ürün Seçiniz'];
    for (var element in depoUrunlerSonuc) {
      if ((!names.contains(element['NAME']) ||
              !codes.contains(element['PRODUCTDEFCODE'])) &&
          element['NAME'] != null) {
        codes.add(element['PRODUCTDEFCODE']);
        names.add(element['NAME']);
      }
    }
    setDepoUrunlerArray = [codes] + [names];
    print('depo urunler array');
    print(depoUrunlerArray);
  }

//Malzeme seçimi Birim

  String _secilenBirim = 'Lütfen Birim Seçiniz';

  String get secilenBirim => _secilenBirim;

  set setSecilenBirim(String secilenBirim) {
    _secilenBirim = secilenBirim;
    notifyListeners();
  }

  String _secilenBirimValue = '';

  String get secilenBirimValue => _secilenBirimValue;

  set setSecilenBirimValue(String secilenBirimValue) {
    _secilenBirimValue = secilenBirimValue;
    notifyListeners();
  }

  List _depoBirimlerArray = [];

  List get depoBirimlerArray => _depoBirimlerArray;
  set setDepoBirimlerArray(List depoBirimlerArray) {
    _depoBirimlerArray = depoBirimlerArray;
    notifyListeners();
  }

  getBirimler(productDefCode) async {
    setDepoBirimlerArray = [];
    final depoBirimlerSonuc =
        await apirepository.getPackageInfoByProduct(productDefCode);
    print('depoBirimlerSonuc : ');
    print(depoBirimlerSonuc);
    List<String> codes = ['Lütfen Birim Seçiniz'];
    List<String> names = ['Lütfen Birim Seçiniz'];
    for (var element in depoBirimlerSonuc) {
      codes.add(element['CODE']);
      names.add(element['UNITCODE']);
    }
    setDepoBirimlerArray = [codes] + [names];
    print('depo birimler array');
    print(depoBirimlerArray);
  }

  /// Adet
  ///
  // String _malzemeMiktari = '';

  // String get malzemeMiktari => _malzemeMiktari;

  // set setMalzemeMiktari(String malzemeMiktari) {
  //   _malzemeMiktari = malzemeMiktari;
  //   notifyListeners();
  // }
  final _malzemeMiktari = TextEditingController();

  TextEditingController get malzemeMiktari => _malzemeMiktari;

  set setMalzemeMiktari(String malzemeMiktari) {
    _malzemeMiktari.text = malzemeMiktari;
    notifyListeners();
  }

  woAddMaterial(context, product, amount, unit) async {
    final addMaterialResponse =
        await apirepository.woAddMaterialApi(woCode, product, amount, unit);
    if (addMaterialResponse == true) {
      snackBar(context, 'Malzeme başarıyla eklendi ', 'success');
      Navigator.pop(context);
    } else {
      snackBar(context, 'Malzeme eklenirken hata oluştu ', 'error');
    }
  }
}
