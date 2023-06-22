// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/models/detail_activities.model.dart';
import 'package:win_kamu/models/detail_view.model.dart';
import 'package:win_kamu/models/issue_summary.modal.dart';
import 'package:win_kamu/utils/api_urls.dart';

class EnvironmentProvider extends ChangeNotifier {
  final apirepository = APIRepository();

  List<Map<String, String>> _endpoints = [
    {
      'PPP_PROJECT': 'antep',
      'BASE_URL_V2': 'http://wd-mobile-test.gaziantep.yerel',
      'TOKEN_V1': 'anteptest!_',
      'TOKEN_V2': 'anteptest!',
      'ATTACHPATHLIVE': "http://geskwdtestapp.gaziantep.yerel/windesk/xreadattach.php?token=${TOKEN_V1}&id=",
      'base_url_v1': 'http://geskwdtestapp.gaziantep.yerel/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
          'wdmobile' +
          '&wspassword=' +
          'wdsgnm1017_' +
          '&token=',
    },
    {
      'PPP_PROJECT': 'antep',
      'BASE_URL_V2': 'http://wd-mobile-test.gaziantep.yerel',
      'TOKEN_V1': 'anteptest!_',
      'TOKEN_V2': 'anteptest!',
      'ATTACHPATHLIVE': "http://geskwdtestapp.gaziantep.yerel/windesk/xreadattach.php?token=${TOKEN_V1}&id=",
      'base_url_v1': 'http://geskwdtestapp.gaziantep.yerel/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
          'wdmobile' +
          '&wspassword=' +
          'wdsgnm1017_' +
          '&token=',
    },
    // Add more endpoints as needed
  ];

  List<DetailViewModel> queryParameters = [];

  List<DetailActivitiesModal> _listViewActivities = [];
  List<DetailActivitiesModal> tempListViewActivities = [];

  List<IssueSummaryModal> _issueSummary = [];
  List<IssueSummaryModal> tempIssueSummary = [];

  String? _responses;

  String? _selectedHospital;
  bool _isDataLoading = true;
  bool _loading = false;
  bool _isDataExist = false;
  int _toplamKayitSayisi = 0;

  List<Map<String, String>> get endpoints => _endpoints;
  set setiendpoints(List<Map<String, String>> endpoints) {
    _endpoints = endpoints;
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

  get selectedHospital => _selectedHospital;

  set setselectedHospital(String selectedHospital) {
    _selectedHospital = selectedHospital;
    notifyListeners();
  }

  get responses => _responses;

  set setresponses(String responses) {
    _selectedHospital = selectedHospital;
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

  sendIssueActivity(String issueCode, String userName, String activityCode, String description) async {
    if (description.toString().length < 20 && activityCode.toString() == 'AR00000001336') {
      return 'Lütfen yeterli uzunlukta açıklama giriniz';
    } else {
      final apiresult =
          await apirepository.addIssueActivity(userName: userName, issueCode: issueCode, activityCode: activityCode, description: description);

      final results = jsonDecode(apiresult.toString());

      print('activity inside 2 ' + results['resultcode'].toString());

      if (results['success'].toString() == 'false') {
        //_responses = results['resultcode'];
        print('activityresponse' + results['success'].toString());
        //notifyListeners();
        return 'Aktivite girişi başarısız';
      } else {
        return 'Aktivite girişi başarılı.';
      }
    }
  }
}
