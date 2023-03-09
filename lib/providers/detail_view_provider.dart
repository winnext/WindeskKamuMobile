import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/components/crud_view/crud_view.dart';
import 'package:win_kamu/models/detail_response.model.dart';
import 'package:win_kamu/models/detail_view.model.dart';
import 'package:win_kamu/utils/api_urls.dart';
import 'package:provider/provider.dart';

import '../models/http_response.model.dart';
import '../utils/global_utils.dart';
import 'main_page_view_provider.dart';

class DetailViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();
  var data;

  List<DetailViewModel> _exampleListView = [];
  List<DetailViewModel> tempexampleListView = [];
  List<DetailViewModel> queryParameters = [];

  String? _issueCode;
  bool _isDataLoading = true;
  bool _loading = false;
  bool _isDataExist = false;

  List<DetailViewModel> get exampleListView => _exampleListView;
  set setiexampleListView(List<DetailViewModel> exampleListView) {
    _exampleListView = exampleListView;
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

  bool get isDataExist => _isDataExist;

  set setisDataExist(bool isDataExist) {
    _isDataExist = isDataExist;
    notifyListeners();
  }

  loadData(String issuecode, String xusercode) async {
    _isDataLoading = true;

    final responseUrl = getIssueDetail + '/${issueCode}';

    final data = await apirepository.getRequestDetail(
        controller: responseUrl, issueCode: issuecode, xuserCode: xusercode);

    print('issueDetail3 : ' + queryParameters.toString() + ' +++ ' + responseUrl.toString());

    if (true) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        var responseData = DetailViewModel.fromJson(data.detail['detail']);

        exampleListView.add(responseData);

        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }
}
