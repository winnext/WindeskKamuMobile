// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/models/tracing_view.model.dart';
import 'package:win_kamu/models/woListView.model.dart';
import 'package:win_kamu/utils/api_urls.dart';

import '../models/issue_filter.modal.dart';

class WorkOrderProvider extends ChangeNotifier {
  final apirepository = APIRepository();
  List<WoListViewModel> _woListView = [];
  List<WoListViewModel> tempwoListView = [];

  List<TracingViewModal> _tracingListView = [];
  List<TracingViewModal> temptracingListView = [];

  List<IssueFilterModel> _woFilterStatusCodes = [];
  List<IssueFilterModel> tempwoFilterStatusCodes = [];

  List<IssueFilterModel> _woFilterBuildCodes = [];
  List<IssueFilterModel> tempwoFilterBuildCodes = [];

  List<IssueFilterModel> _woFilterFloorCodes = [];
  List<IssueFilterModel> tempwoFilterFloorCodes = [];

  List<IssueFilterModel> _woFilterWingCodes = [];
  List<IssueFilterModel> tempwoFilterWingCodes = [];

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
  String? woListCode;

  PageController? get pageController => _pageController;
  set setpageController(PageController pageController) {
    _pageController = pageController;
    notifyListeners();
  }

  List<WoListViewModel> get woListView => _woListView;
  set setiwoListView(List<WoListViewModel> woListView) {
    _woListView = woListView;
    notifyListeners();
  }

  List<TracingViewModal> get tracingListView => _tracingListView;
  set setitracingListView(List<TracingViewModal> tracingListView) {
    _tracingListView = tracingListView;
    notifyListeners();
  }

  List<IssueFilterModel> get woFilterStatusCodes => _woFilterStatusCodes;
  set setiwoFilterStatusCodes(List<IssueFilterModel> woFilterStatusCodes) {
    _woFilterStatusCodes = woFilterStatusCodes;
    notifyListeners();
  }

  List<IssueFilterModel> get woFilterBuildCodes => _woFilterBuildCodes;
  set setiwoFilterBuildCodes(List<IssueFilterModel> woFilterBuildCodes) {
    _woFilterBuildCodes = woFilterBuildCodes;
    notifyListeners();
  }

  List<IssueFilterModel> get woFilterFloorCodes => _woFilterFloorCodes;
  set setiwoFilterFloorCodes(List<IssueFilterModel> woFilterFloorCodes) {
    _woFilterFloorCodes = woFilterFloorCodes;
    notifyListeners();
  }

  List<IssueFilterModel> get woFilterWingCodes => _woFilterWingCodes;
  set setiwoFilterWingCodes(List<IssueFilterModel> woFilterWingCodes) {
    _woFilterWingCodes = woFilterWingCodes;
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

  int get currentPage => _currentPage;

  set setcurrentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  bool notificationController(ScrollNotification scrollInfo) {
    if (!_isDataLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (_toplamKayitSayisi != null && _woListView.length >= _toplamKayitSayisi) {
        return false;
      }
      _currentPage = 1 + _currentPage;
      getListWorkOrders(_currentPage, woListCode);
      _isDataLoading = true;
      notifyListeners();
    } else {}
    return false;
  }

  void getListWorkOrders(index, listCode) async {
    _isDataLoading = true;
    int _startWo = index == 1 ? 0 : (index - 1) * 10;
    int _endWo = index * 10;

    Map<String, dynamic> queryParameters = {
      "start": _startWo,
      "end": _endWo,
      "status": statusCode,
      "build": buildCode,
      "floor": floor,
      "responsible": assigne,
    };

    woListCode = listCode;

    final urlIssueTypes = '$BASE_URL_V2/list/$woListCode/workorder';

    final result = await apirepository.getListWorkOrders(controller: urlIssueTypes, queryParameters: queryParameters);

    final data = result.records['records'];

    print('dataWoList$data');

    if (true) {
      tempwoListView = (result.records['records'] as List).map((e) => WoListViewModel.fromJson(e)).toList();
      Future.delayed(const Duration(milliseconds: 1200), () {
        woListView.addAll(tempwoListView);
        _toplamKayitSayisi = int.parse(result.records['totalcount']);
        int noOfTasks = tempwoListView.length;
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
    final urlIssueTypes = '$base_url_v1$TOKEN_V1$deviceToken&action=getIssueOpenStatusCodes';

    final result = await apirepository.getIssueOpenStatusCodes(controller: urlIssueTypes);

    if (true) {
      tempwoFilterStatusCodes = (result.records['records'] as List).map((e) => IssueFilterModel.fromJson(e)).toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        woFilterStatusCodes.addAll(tempwoFilterStatusCodes);
        int noOfTasks = tempwoFilterStatusCodes.length;

        print('dataActivities ++++2${woFilterStatusCodes[0].CODE}');

        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getTracingListWithCount(xusercode, module) async {
    _isDataLoading = true;

    final urlIssueTypes = '$BASE_URL_V2/list/module/$module';

    final result = await apirepository.getTracingListWithCount(controller: urlIssueTypes, xusercode: xusercode, module: module);

    final data = result.lists['lists'];

    if (true) {
      temptracingListView = (data as List).map((e) => TracingViewModal.fromJson(e)).toList();

      Future.delayed(const Duration(milliseconds: 1200), () {
        tracingListView.addAll(temptracingListView);
        int noOfTasks = temptracingListView.length;
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

  void getSpaceBfwByType(String type) async {
    _isDataLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();
    final urlIssueTypes = '$base_url_v1$TOKEN_V1$deviceToken&action=getSpaceBfwByType&type=$type';

    final result = await apirepository.getSpaceBfwByType(controller: urlIssueTypes);

    final data = result.records['records'];

    if (type == 'BUILDING') {
      tempwoFilterBuildCodes = (result.records['records'] as List).map((e) => IssueFilterModel.fromJson(e)).toList();
      print('buildinggg$tempwoFilterStatusCodes');

      woFilterBuildCodes.addAll(tempwoFilterBuildCodes);
      int noOfTasks = tempwoFilterBuildCodes.length;
      _isDataLoading = false;
      _loading = false;
      _isDataExist = false;
      notifyListeners();
    } else if (type == 'FLOOR') {
      tempwoFilterFloorCodes = (result.records['records'] as List).map((e) => IssueFilterModel.fromJson(e)).toList();

      woFilterFloorCodes.addAll(tempwoFilterFloorCodes);
      int noOfTasks = tempwoFilterFloorCodes.length;

      _isDataLoading = false;
      _loading = false;
      _isDataExist = false;
      notifyListeners();
    } else if (type == 'WING') {
      tempwoFilterWingCodes = (result.records['records'] as List).map((e) => IssueFilterModel.fromJson(e)).toList();

      woFilterWingCodes.addAll(tempwoFilterWingCodes);
      int noOfTasks = tempwoFilterWingCodes.length;

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
