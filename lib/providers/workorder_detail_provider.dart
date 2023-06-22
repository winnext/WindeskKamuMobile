// ignore_for_file: prefer_typing_uninitialized_variables, dead_code, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/models/detail_activities.model.dart';
import 'package:win_kamu/models/issue_summary.modal.dart';
import 'package:win_kamu/utils/api_urls.dart';

import '../models/worelated_modal.dart';
import '../models/workoder_detail_modal.dart';

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

  loadWoDetail(String woCode, String xusercode) async {
    print('LoadWoDetail ');
    woDetailView.clear();

    _isDataLoading = true;

    final responseUrl = '$BASE_URL_V2/workorder/detail/${woCode}';
    final data = await apirepository.getRequestDetail(controller: responseUrl, issueCode: woCode, xuserCode: xusercode);
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
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  woGetRelatedSpace(String woCode, String xusercode) async {
    _isDataLoading = true;

    final responseUrl = '$BASE_URL_V2/workorder/${woCode}/space';
    final data = await apirepository.woGetRelatedSpace(controller: responseUrl, xuserCode: xusercode);
    print('woReleatedd${data.records['records']}');

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        woRelatedView.clear();
        tempwoRelatedView = (data.records['records'] as List).map((e) => WoRelatedViewModel.fromJson(e)).toList();
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

  sendIssueActivity(String woCode, String userName, String activityCode, String description) async {
    if (description.toString().length < 20 && activityCode.toString() == 'AR00000001336') {
      return 'Lütfen yeterli uzunlukta açıklama giriniz';
    } else {
      final apiresult =
          await apirepository.addIssueActivity(userName: userName, issueCode: woCode, activityCode: activityCode, description: description);

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
    notifyListeners();
  }

  //eforlar gun
  String _secilenGun = '1';

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
    final result = apirepository.addEffortApi(code, workPeriod);
    print(result);
  }

  // Eforlar
  List _eforlarArray = [];

  List get eforlarArray => _eforlarArray;
  set setEforlarArray(List eforlarArray) {
    _eforlarArray = eforlarArray;
    notifyListeners();
  }

  getWorkOrderWorklogs(woCode) async {
    List<String> codes = [];
    List<String> users = [];
    List<String> timeworkeds = [];

    final result2 = await apirepository.getWorkOrderWorklogsApi(woCode);
    print(result2);

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
}
