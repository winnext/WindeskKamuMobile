// ignore_for_file: prefer_typing_uninitialized_variables, dead_code, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/models/detail_activities.model.dart';
import 'package:win_kamu/models/detail_view.model.dart';
import 'package:win_kamu/models/issue_summary.modal.dart';
import 'package:win_kamu/utils/api_urls.dart';

class DetailViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();

  List<DetailViewModel> _exampleListView = [];
  List<DetailViewModel> tempexampleListView = [];
  List<DetailViewModel> queryParameters = [];

  List<DetailActivitiesModal> _listViewActivities = [];
  List<DetailActivitiesModal> tempListViewActivities = [];

  List<IssueSummaryModal> _issueSummary = [];
  List<IssueSummaryModal> tempIssueSummary = [];

  String? _responses;
  String? _issueCode;

  bool _isDataLoading = true;
  bool _loading = false;
  bool _isDataExist = false;
  int _toplamKayitSayisi = 0;

  List<DetailViewModel> get exampleListView => _exampleListView;
  set setiexampleListView(List<DetailViewModel> exampleListView) {
    _exampleListView = exampleListView;
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

  get issueCode => _issueCode;

  set setIssueCode(String issueCode) {
    _issueCode = issueCode;
    notifyListeners();
  }

  get responses => _responses;

  set setresponses(String responses) {
    _issueCode = issueCode;
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

  loadData(String issuecode, String xusercode) async {
    _isDataLoading = true;

    final responseUrl = '$BASE_URL_V2/issue/${issueCode}';
    final data = await apirepository.getRequestDetail(controller: responseUrl, issueCode: issuecode, xuserCode: xusercode);

    if (true) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        var responseData = DetailViewModel.fromJson(data.detail['detail']);
        print('objectissueDetailll' +
            responseData.TARGET_FDATE.toString() + ' : ' + responseData.RELATEDCODE.toString());
        exampleListView.clear();
        exampleListView.add(responseData);
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
    }
  }

  loadIssueSummary(String issuecode, String xusercode) async {
    _isDataLoading = true;
    final responseUrl = '$BASE_URL_V2/issue/${issueCode}/summary';

    final data = await apirepository.getIssueSummary(controller: responseUrl, issueCode: issuecode, xuserCode: xusercode);

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        var responseData = IssueSummaryModal.fromJson(data.detail['detail']);
        _issueSummary.add(responseData);
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  sendIssueActivity(String issueCode, String userName, String activityCode, String description) async {
    if (description.toString().length < 20 && activityCode.toString() == 'AR00000001336') {
      return 'Lütfen yeterli uzunlukta açıklama giriniz';
    } else {
      final apiresult =
          await apirepository.addIssueActivity(userName: userName, issueCode: issueCode, activityCode: activityCode, description: description);

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
}
