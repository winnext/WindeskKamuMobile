import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/components/crud_view/crud_view.dart';
import 'package:win_kamu/models/issue_activities.modal.dart';
import 'package:win_kamu/models/issue_operations.modal.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/models/tracing_view.model.dart';
import 'package:win_kamu/pages/issue/routeIssue.dart';
import 'package:win_kamu/utils/api_urls.dart';
import 'package:provider/provider.dart';

import '../models/http_response.model.dart';
import '../models/issue_attachments.modal.dart';
import '../models/issue_filter.modal.dart';
import '../models/issue_notes.modal.dart';
import '../utils/global_utils.dart';
import 'main_page_view_provider.dart';

class ListViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();
  String? issueListType;
  List<ListViewModel> _exampleListView = [];
  List<ListViewModel> tempexampleListView = [];

  List<TracingViewModal> _tracingListView = [];
  List<TracingViewModal> temptracingListView = [];

  List<IssueActivitiesModal> _issueActivitiesView = [];
  List<IssueActivitiesModal> tempissueActivitiesView = [];

  List<IssueNotesModal> _issueNotesView = [];
  List<IssueNotesModal> tempissueNotesView = [];

  List<IssueAttachmentModal> _issueAttachmentView = [];
  List<IssueAttachmentModal> tempissueAttachmentView = [];

  List<IssueFilterModel> _issueFilterStatusCodes = [];
  List<IssueFilterModel> tempissueFilterStatusCodes = [];

  List<IssueFilterModel> _issueFilterBuildCodes = [];
  List<IssueFilterModel> tempissueFilterBuildCodes = [];

  List<IssueFilterModel> _issueFilterFloorCodes = [];
  List<IssueFilterModel> tempissueFilterFloorCodes = [];

  List<IssueFilterModel> _issueFilterWingCodes = [];
  List<IssueFilterModel> tempissueFilterWingCodes = [];

  List<IssueOperationsModal> _issueOperationList = [];
  List<IssueOperationsModal> tempissueOperationList = [];

  PageController? _pageController;

  bool _isDataLoading = true;
  bool _loading = false;
  bool _isDataExist = false;
  int _currentPage = 1;
  int _toplamKayitSayisi = 0;
  String _moduleCode = '';
  String _moduleName = '';
  String _statusName = '';
  String _statusCode = '';
  String _buildName = '';
  String _buildCode = '';
  String _floor = '';
  String _wing = '';
  String _assigne = '';

  PageController? get pageController => _pageController;
  set setpageController(PageController pageController) {
    _pageController = pageController;
    notifyListeners();
  }

  List<ListViewModel> get exampleListView => _exampleListView;
  set setiexampleListView(List<ListViewModel> exampleListView) {
    _exampleListView = exampleListView;
    notifyListeners();
  }

  List<TracingViewModal> get tracingListView => _tracingListView;
  set setitracingListView(List<TracingViewModal> tracingListView) {
    _tracingListView = tracingListView;
    notifyListeners();
  }

  List<IssueActivitiesModal> get issueActivitiesView => _issueActivitiesView;
  set setiissueActivitiesView(List<IssueActivitiesModal> issueActivitiesView) {
    _issueActivitiesView = issueActivitiesView;
    notifyListeners();
  }

  List<IssueNotesModal> get issueNotesView => _issueNotesView;
  set setiissueNotesView(List<IssueNotesModal> issueNotesView) {
    _issueNotesView = issueNotesView;
    notifyListeners();
  }

  List<IssueAttachmentModal> get issueAttachmentView => _issueAttachmentView;
  set setiissueAttachmentView(List<IssueAttachmentModal> issueAttachmentView) {
    _issueAttachmentView = issueAttachmentView;
    notifyListeners();
  }

  List<IssueFilterModel> get issueFilterStatusCodes => _issueFilterStatusCodes;
  set setiissueFilterStatusCodes(
      List<IssueFilterModel> issueFilterStatusCodes) {
    _issueFilterStatusCodes = issueFilterStatusCodes;
    notifyListeners();
  }

  List<IssueFilterModel> get issueFilterBuildCodes => _issueFilterBuildCodes;
  set setiissueFilterBuildCodes(List<IssueFilterModel> issueFilterBuildCodes) {
    _issueFilterBuildCodes = issueFilterBuildCodes;
    notifyListeners();
  }

  List<IssueFilterModel> get issueFilterFloorCodes => _issueFilterFloorCodes;
  set setiissueFilterFloorCodes(List<IssueFilterModel> issueFilterFloorCodes) {
    _issueFilterFloorCodes = issueFilterFloorCodes;
    notifyListeners();
  }

  List<IssueFilterModel> get issueFilterWingCodes => _issueFilterWingCodes;
  set setiissueFilterWingCodes(List<IssueFilterModel> issueFilterWingCodes) {
    _issueFilterWingCodes = issueFilterWingCodes;
    notifyListeners();
  }

  List<IssueOperationsModal> get issueOperationList => _issueOperationList;
  set setiissueOperationList(List<IssueOperationsModal> issueOperationList) {
    _issueOperationList = issueOperationList;
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

  bool get isDataExist => _isDataExist;

  set setisDataExist(bool isDataExist) {
    _isDataExist = isDataExist;
    notifyListeners();
  }

  int get toplamKayitSayisi => _toplamKayitSayisi;

  set settoplamKayitSayisi(int toplamKayitSayisi) {
    _toplamKayitSayisi = toplamKayitSayisi;
    notifyListeners();
  }

  String get moduleCode => _moduleCode;
  set setmoduleCode(String moduleCode) {
    _moduleCode = moduleCode;
    notifyListeners();
  }

  String get moduleName => _moduleName;
  set setmoduleName(String moduleName) {
    _moduleName = moduleName;
    notifyListeners();
  }

  String get statusName => _statusName;
  set setstatusName(String statusName) {
    _statusName = statusName;
    notifyListeners();
  }

  String get statusCode => _statusCode;
  set setstatusCode(String statusCode) {
    _statusCode = statusCode;
    notifyListeners();
  }

  String get buildName => _buildName;
  set setbuildName(String buildName) {
    _buildName = buildName;
    notifyListeners();
  }

  String get buildCode => _buildCode;
  set setbuildCode(String buildCode) {
    _buildCode = buildCode;
    notifyListeners();
  }

  String get floor => _floor;
  set setfloor(String floor) {
    _floor = floor;
    notifyListeners();
  }

  String get wing => _wing;
  set setwing(String wing) {
    _wing = wing;
    notifyListeners();
  }

  String get assigne => _assigne;
  set setassigne(String assigne) {
    _assigne = assigne;
    notifyListeners();
  }

  int get currentPage => _currentPage;

  set setcurrentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  bool notificationController(ScrollNotification scrollInfo) {
    if (!_isDataLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (_toplamKayitSayisi != null &&
          _exampleListView.length >= _toplamKayitSayisi) {
        return false;
      }
      _currentPage = 1 + _currentPage;
      loadData(_currentPage, issueListType);
      _isDataLoading = true;
      notifyListeners();
    } else {}
    return false;
  }

  void loadData(index, issueType) async {
    _isDataLoading = true;
    int _startIssues = index == 1 ? 0 : (index - 1) * 10;
    int _endIsses = index * 10;

    Map<String, dynamic> queryParameters = {
      "start": _startIssues,
      "end": _endIsses,
      "status": statusCode,
      "build": buildCode,
      "floor": floor,
      "wing": wing,
      "assignee": assigne,
    };

    issueListType = issueType;

    final urlIssueTypes = '${BASE_URL_V2}/list/$issueListType/issue';

    final result = await apirepository.getListForPaging(
        controller: urlIssueTypes, queryParameters: queryParameters);

    final data = result.records['records'];

    print('urlISSUE' + data.toString());

    if (true) {
      tempexampleListView = (result.records['records'] as List)
          .map((e) => ListViewModel.fromJson(e))
          .toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        exampleListView.addAll(tempexampleListView);
        _toplamKayitSayisi = int.parse(result.records['totalcount']);
        int noOfTasks = tempexampleListView.length;
        if (noOfTasks > 0) {
          _isDataLoading = false;
          _loading = false;
          _isDataExist = false;
          notifyListeners();
        } else {
          _currentPage = 1;

          _isDataExist = false;
          _loading = false;
          _isDataLoading = false;
          notifyListeners();
        }
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getTracingListWithCount(xusercode, module) async {
    _isDataLoading = true;

    final urlIssueTypes = '${BASE_URL_V2}/list/module/${module}';

    final result = await apirepository.getTracingListWithCount(
        controller: urlIssueTypes, xusercode: xusercode, module: module);

    final data = result.lists['lists'];

    if (true) {
      temptracingListView =
          (data as List).map((e) => TracingViewModal.fromJson(e)).toList();

      Future.delayed(const Duration(milliseconds: 0), () {
        tracingListView.addAll(temptracingListView);

        _isDataLoading = false;
        _loading = false;
        _isDataExist = true;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getIssueActivities(xusercode, issuecode) async {
    _isDataLoading = true;

    final urlIssueTypes = '${BASE_URL_V2}/issue/${issuecode}/activities';

    final result = await apirepository.getIssueActivities(
        controller: urlIssueTypes, xusercode: xusercode, issuecode: issuecode);

    final data = result.records['records'];

    print('dataActivities ++++5 ' + data.toString());
    if (true) {
      tempissueActivitiesView = (result.records['records'] as List)
          .map((e) => IssueActivitiesModal.fromJson(e))
          .toList();
      print('dataActivities ++++55 ' + tempissueActivitiesView.toString());

      Future.delayed(const Duration(milliseconds: 0), () {
        issueActivitiesView.addAll(tempissueActivitiesView);
        int noOfTasks = tempissueActivitiesView.length;
        if (noOfTasks > 0) {
          _isDataLoading = false;
          _loading = false;
          _isDataExist = false;
          notifyListeners();
        } else {
          _currentPage = 1;
          _isDataExist = false;
          _loading = false;
          _isDataLoading = false;
          notifyListeners();
        }
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getIssueNotes(issuecode) async {
    _isDataLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    final urlIssueTypes =
        '${base_url_v1}${TOKEN_V1}${deviceToken}&action=getNotes&module=issue&moduleCode=${issuecode}';

    final result = await apirepository.getIssueNotes(controller: urlIssueTypes);

    if (true) {
      tempissueNotesView = (result.records['records'] as List)
          .map((e) => IssueNotesModal.fromJson(e))
          .toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        issueNotesView.addAll(tempissueNotesView);
        int noOfTasks = tempissueNotesView.length;
        if (noOfTasks > 0) {
          _isDataLoading = false;
          _loading = false;
          _isDataExist = false;
          notifyListeners();
        } else {
          _currentPage = 1;
          _isDataExist = false;
          _loading = false;
          _isDataLoading = false;
          notifyListeners();
        }
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getIssueAttachments(xusercode, issuecode) async {
    _isDataLoading = true;

    final urlIssueTypes = '${BASE_URL_V2}/issue/${issuecode}/attachments';

    final result = await apirepository.getIssueAttachments(
        controller: urlIssueTypes, xusercode: xusercode, issuecode: issuecode);

    final data = result.records['records'];

    //print('dataActivities ++++ ' + data.toString());
    if (true) {
      tempissueAttachmentView = (result.records['records'] as List)
          .map((e) => IssueAttachmentModal.fromJson(e))
          .toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        issueAttachmentView.addAll(tempissueAttachmentView);
        int noOfTasks = tempissueAttachmentView.length;
        if (noOfTasks > 0) {
          _isDataLoading = false;
          _loading = false;
          _isDataExist = false;
          notifyListeners();
        } else {
          _currentPage = 1;
          _isDataExist = false;
          _loading = false;
          _isDataLoading = false;
          notifyListeners();
        }
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getIssueOperations(issuecode, xusercode) async {
    _isDataLoading = true;

    final urlIssueTypes = '${BASE_URL_V2}/issue/${issuecode}/operationList';

    print('dataActivitiesUrl' + urlIssueTypes.toString());

    final result = await apirepository.getIssueOperations(
        controller: urlIssueTypes, xusercode: xusercode);

    final data = result.records['records'];

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        issueOperationList.clear();
        var responseData =
            IssueOperationsModal.fromJson(result.records['records']);
        issueOperationList.add(responseData);
        print('issueOperationList' +
            issueOperationList[0].IS_ACTIVITY.toString());

        int noOfTasks = issueOperationList.length;
        if (noOfTasks > 0) {
          _isDataLoading = false;
          _loading = false;
          _isDataExist = false;
          notifyListeners();
        } else {
          _currentPage = 1;
          _isDataExist = false;
          _loading = false;
          _isDataLoading = false;
          notifyListeners();
        }
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getIssueOpenStatusCodes() async {
    _isDataLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();
    final urlIssueTypes =
        '${base_url_v1}${TOKEN_V1}${deviceToken}&action=getIssueOpenStatusCodes';

    final result =
        await apirepository.getIssueOpenStatusCodes(controller: urlIssueTypes);

    print('filterstatus' + result.records['records'].toString());

    if (true) {
      issueFilterStatusCodes.clear();
      tempissueFilterStatusCodes = (result.records['records'] as List)
          .map((e) => IssueFilterModel.fromJson(e))
          .toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        issueFilterStatusCodes.addAll(tempissueFilterStatusCodes);
        int noOfTasks = tempissueFilterStatusCodes.length;

        print(
            'dataActivities ++++2' + issueFilterStatusCodes[0].CODE.toString());

        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getSpaceBfwByType(String type) async {
    _isDataLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();
    final urlIssueTypes =
        '${base_url_v1}${TOKEN_V1}${deviceToken}&action=getSpaceBfwByType&type=${type}';

    final result =
        await apirepository.getSpaceBfwByType(controller: urlIssueTypes);

    final data = result.records['records'];

    if (type == 'BUILDING') {
      issueFilterBuildCodes.clear();
      tempissueFilterBuildCodes = (result.records['records'] as List)
          .map((e) => IssueFilterModel.fromJson(e))
          .toList();

      issueFilterBuildCodes.addAll(tempissueFilterBuildCodes);
      int noOfTasks = tempissueFilterBuildCodes.length;

      _isDataLoading = false;
      _loading = false;
      _isDataExist = false;
      notifyListeners();
    } else if (type == 'FLOOR') {
      issueFilterFloorCodes.clear();
      tempissueFilterFloorCodes = (result.records['records'] as List)
          .map((e) => IssueFilterModel.fromJson(e))
          .toList();

      issueFilterFloorCodes.addAll(tempissueFilterFloorCodes);
      int noOfTasks = tempissueFilterFloorCodes.length;

      _isDataLoading = false;
      _loading = false;
      _isDataExist = false;
      notifyListeners();
    } else if (type == 'WING') {
      issueFilterWingCodes.clear();
      tempissueFilterWingCodes = (result.records['records'] as List)
          .map((e) => IssueFilterModel.fromJson(e))
          .toList();

      issueFilterWingCodes.addAll(tempissueFilterWingCodes);
      int noOfTasks = tempissueFilterWingCodes.length;

      _isDataLoading = false;
      _loading = false;
      _isDataExist = false;
      notifyListeners();
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void initData([PageController? pageController]) {
    _pageController = pageController;
  }
}
