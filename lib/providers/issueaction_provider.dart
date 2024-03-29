// ignore_for_file: dead_code, avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/api/api_repository.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/utils/api_urls.dart';

import '../models/detail_activities.model.dart';
import '../models/issue_filter.modal.dart';

class IssueActionProvider extends ChangeNotifier {
  final apirepository = APIRepository();
  String? issueListType;
  List<ListViewModel> _exampleListView = [];
  List<ListViewModel> tempexampleListView = [];

  List<DetailActivitiesModal> _activityListView = [];
  List<DetailActivitiesModal> tempActivityListView = [];

  List<IssueFilterModel> _liveSelectAsgGroups = [];
  List<IssueFilterModel> templiveSelectAsgGroups = [];

  List<IssueFilterModel> _liveSelectAsgUsers = [];
  List<IssueFilterModel> templiveSelectAsgUsers = [];

  PageController? _pageController;

  bool _isDataLoading = true;
  bool _loading = false;
  bool _isDataExist = false;
  bool _cfgSuccess = false;
  bool _isActivityAddSuccess = false;
  int _currentPage = 1;
  int _toplamKayitSayisi = 0;
  String _activityCode = '';
  String _activityName = '';
  String _barcodeSpace = '';
  String _additionalTimeInput = '';
  String _assigneeccType = '';
  String _minDescLength = '';
  String _mobilePhoto = '';
  String _liveSelectGroupName = '';
  String _liveSelectGroupCode = '';
  String _liveSelectUserName = '';
  String _liveSelectUserCode = '';
  String _cfgResult = '';
  String _takeOverResult = '';
  String _takeOverMessage = '';
  String _cancelIssueResult = '';
  String _cancelIssueMessage = '';
  String _isPhotoAddSuccess = '';
  String _createSparepartIssueResult = '';
  String _createSparepartIssueMessage = '';
  bool _isDescriptionLengthSuccess = false;

  bool get isDescriptionLengthSuccess => _isDescriptionLengthSuccess;

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

  List<DetailActivitiesModal> get activityListView => _activityListView;
  set setiactivityListView(List<DetailActivitiesModal> activityListView) {
    _activityListView = activityListView;
    notifyListeners();
  }

  List<IssueFilterModel> get liveSelectAsgGroups => _liveSelectAsgGroups;
  set setiliveSelectAsgGroups(List<IssueFilterModel> liveSelectAsgGroups) {
    _liveSelectAsgGroups = liveSelectAsgGroups;
    notifyListeners();
  }

  List<IssueFilterModel> get liveSelectAsgUsers => _liveSelectAsgUsers;
  set setiliveSelectAsgUsers(List<IssueFilterModel> liveSelectAsgUsers) {
    _liveSelectAsgUsers = liveSelectAsgUsers;
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

  bool get cfgSuccess => _cfgSuccess;

  set setcfgSuccess(bool cfgSuccess) {
    _cfgSuccess = cfgSuccess;
    notifyListeners();
  }

  bool get isActivityAddSuccess => _isActivityAddSuccess;

  set setisActivityAddSuccess(bool isActivityAddSuccess) {
    _isActivityAddSuccess = isActivityAddSuccess;
    notifyListeners();
  }

  int get toplamKayitSayisi => _toplamKayitSayisi;

  set settoplamKayitSayisi(int toplamKayitSayisi) {
    _toplamKayitSayisi = toplamKayitSayisi;
    notifyListeners();
  }

  String get activityCode => _activityCode;

  set setactivityCode(String activityCode) {
    _activityCode = activityCode;
    notifyListeners();
  }

  String get activityName => _activityName;

  set setactivityName(String activityName) {
    _activityName = activityName;
    notifyListeners();
  }

  String get barcodeSpace => _barcodeSpace;

  set setbarcodeSpace(String barcodeSpace) {
    _barcodeSpace = barcodeSpace;
    notifyListeners();
  }

  String get additionalTimeInput => _additionalTimeInput;

  set setadditionalTimeInput(String additionalTimeInput) {
    _additionalTimeInput = additionalTimeInput;
    notifyListeners();
  }

  String get assigneeccType => _assigneeccType;

  set setassigneeccType(String assigneeccType) {
    _assigneeccType = assigneeccType;
    notifyListeners();
  }

  String get minDescLength => _minDescLength;

  set setminDescLength(String minDescLength) {
    _minDescLength = minDescLength;
    notifyListeners();
  }

  String get mobilePhoto => _mobilePhoto;

  set setmobilePhoto(String mobilePhoto) {
    _mobilePhoto = mobilePhoto;
    notifyListeners();
  }

  String get liveSelectGroupName => _liveSelectGroupName;

  set setliveSelectGroupName(String liveSelectGroupName) {
    _liveSelectGroupName = liveSelectGroupName;
    notifyListeners();
  }

  String get liveSelectGroupCode => _liveSelectGroupCode;

  set setliveSelectGroupCode(String liveSelectGroupCode) {
    _liveSelectGroupCode = liveSelectGroupCode;
    notifyListeners();
  }

  String get liveSelectUserName => _liveSelectUserName;

  set setliveSelectUserName(String liveSelectUserName) {
    _liveSelectUserName = liveSelectUserName;
    notifyListeners();
  }

  String get liveSelectUserCode => _liveSelectUserCode;

  set setliveSelectUserCode(String liveSelectUserCode) {
    _liveSelectUserCode = liveSelectUserCode;
    notifyListeners();
  }

  String get cfgResult => _cfgResult;

  set setcfgResult(String cfgResult) {
    _cfgResult = cfgResult;
    notifyListeners();
  }

  String get takeOverResult => _takeOverResult;

  set settakeOverResult(String takeOverResult) {
    _takeOverResult = takeOverResult;
    notifyListeners();
  }

  String get takeOverMessage => _takeOverMessage;

  set settakeOverMessage(String takeOverMessage) {
    _takeOverMessage = takeOverMessage;
    notifyListeners();
  }

  String get createSparepartIssueResult => _createSparepartIssueResult;

  set setcreateSparepartIssueResult(String createSparepartIssueResult) {
    _createSparepartIssueResult = createSparepartIssueResult;
    notifyListeners();
  }

  String get createSparepartIssueMessage => _createSparepartIssueMessage;

  set setcreateSparepartIssueMessage(String createSparepartIssueMessage) {
    _createSparepartIssueMessage = createSparepartIssueMessage;
    notifyListeners();
  }

  String get cancelIssueResult => _cancelIssueResult;

  set setcancelIssueResult(String cancelIssueResult) {
    _cancelIssueResult = cancelIssueResult;
    notifyListeners();
  }

  String get cancelIssueMessage => _cancelIssueMessage;

  set setcancelIssueMessage(String cancelIssueMessage) {
    _cancelIssueMessage = cancelIssueMessage;
    notifyListeners();
  }

  String get isPhotoAddSuccess => _isPhotoAddSuccess;

  set setisPhotoAddSuccess(String isPhotoAddSuccess) {
    _isPhotoAddSuccess = isPhotoAddSuccess;
    notifyListeners();
  }

  int get currentPage => _currentPage;

  set setcurrentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  void takeOverIssue(issuecode, username) async {
    _isDataLoading = true;
    //final issueCode = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    final urlIssueTypes = '$base_url_v1$TOKEN_V1$deviceToken&action=takeOverIssue&issueCode=$issuecode&username=$username';

    final result = await apirepository.takeOverIssue(controller: urlIssueTypes);

    final data = result.records['result'];

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        settakeOverResult = data.toString();
        settakeOverMessage = result.records['message'].toString();
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void createSparepartIssue(issuecode, username) async {
    _isDataLoading = true;
    //final issueCode = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    final urlIssueTypes = '$base_url_v1$TOKEN_V1$deviceToken&action=createSparepartIssue&issuecode=$issuecode';

    final result = await apirepository.createSparepartIssue(controller: urlIssueTypes);

    final resultt = result.records['result'];
    final message = result.records['msg'];

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        setcreateSparepartIssueResult = resultt.toString();
        setcreateSparepartIssueMessage = message.toString();
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void cancelIssuePlanned(issuecode, username) async {
    _isDataLoading = true;
    //final issueCode = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    final urlIssueTypes = '$base_url_v1$TOKEN_V1$deviceToken&action=cancelIssuePlanned&issueCode=$issuecode&username=$username';

    final result = await apirepository.cancelIssuePlanned(controller: urlIssueTypes);

    print('resultIssuePlanned${result.message} : ${result.records}');

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        setcancelIssueResult = result.records['result'].toString();
        setcancelIssueMessage = result.records['resultcode'].toString();
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void getAvailableActivities(issuecode) async {
    _isDataLoading = true;
    //final issueCode = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String urlActivities = '$base_url_v1$TOKEN_V1$deviceToken&action=getAvailableActivities&issueCode=${issuecode!}&module=issue';

    final result = await apirepository.takeOverIssue(controller: urlActivities);

    final data = result.records['records'];

    print('getAvailableActivities123$data');

    if (true) {
      activityListView.clear();
      tempActivityListView = (result.records['records'] as List).map((e) => DetailActivitiesModal.fromJson(e)).toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        activityListView.addAll(tempActivityListView);
        _toplamKayitSayisi = tempActivityListView.length;
        int noOfTasks = tempActivityListView.length;
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

  void getLiveSelectAsgGroups(issuecode) async {
    _isDataLoading = true;
    //final issueCode = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String urlActivities = '$base_url_v1$TOKEN_V1$deviceToken&action=getLiveSelectAsgGroups&issueCode=$issuecode';

    final result = await apirepository.getLiveSelectAsgGroups(controller: urlActivities);

    final data = result.records['records'];

    print('data$data');

    if (true) {
      liveSelectAsgGroups.clear();
      templiveSelectAsgGroups = (result.records['records'] as List).map((e) => IssueFilterModel.fromJson(e)).toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        liveSelectAsgGroups.addAll(templiveSelectAsgGroups);
        int noOfTasks = templiveSelectAsgGroups.length;
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

  void getLiveSelectAsgUser(asgGroupCode) async {
    _isDataLoading = true;
    //final asg = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String urlActivities = '$base_url_v1$TOKEN_V1$deviceToken&action=getLiveSelectUsers&asgGroupCode=${asgGroupCode!}';

    final result = await apirepository.getLiveSelectAsgUser(controller: urlActivities);

    final data = result.records['records'];

    print('dataASGUSER$data');

    if (true) {
      liveSelectAsgUsers.clear();
      templiveSelectAsgUsers = (result.records['records'] as List).map((e) => IssueFilterModel.fromJson(e)).toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        liveSelectAsgUsers.addAll(templiveSelectAsgUsers);
        int noOfTasks = templiveSelectAsgUsers.length;
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

  void changeCfg(cfgCode, issueCode) async {
    _isDataLoading = true;
    //final asg = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String urlActivities = '$base_url_v1$TOKEN_V1$deviceToken&action=changeCfg&issuecode=${issueCode!}&cfgCode=$cfgCode';

    final result = await apirepository.changeCfg(controller: urlActivities);

    final cfgSuccess = result.records['success'];
    final cfgResult = result.records['result'];

    print('dataCFG$result');

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        setcfgResult = cfgResult;
        setcfgSuccess = cfgSuccess;
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        notifyListeners();
        _currentPage = 1;
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void addActivityMethod(
    code,
    username,
    activityCode,
    description,
    locationCode,
    asgGroupCode,
    asgUserCode,
    additionalTime,
    module,
    image,
    cardNo,
    patientNo,
    sampleNo,
  ) async {
    _isDataLoading = true;
    //final asg = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    if (description.toString().length < 20) {
      _isDescriptionLengthSuccess = false;
      notifyListeners();
    } else {
      String urlActivities =
          '$base_url_v1$TOKEN_V1$deviceToken&action=addActivity&issueCode=$code&username=$username&activityCode=$activityCode&locationCode=$locationCode&asgGroupCode=$asgGroupCode&asgUserCode=$asgUserCode&additionalTime=$additionalTime&module=issue&from_mobile=1&cardNo=$cardNo&patientNo=$patientNo&sampleNo=$sampleNo&description=$description';
      final result = await apirepository.addActivity(controller: urlActivities, description: description, image: image);

      print('addActivityPro' + result.records['resultcode'].toString());

      if (true) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _isDescriptionLengthSuccess = true;
          _isActivityAddSuccess = result.records['success'].toString() == 'true' ? true : false;
          _isDataLoading = false;
          _loading = false;
          _isDataExist = false;
          notifyListeners();
          _currentPage = 1;
        });
      } else {
        // baglantiHatasi(context, result.message);
      }
    }
  }

  void addAttachmentMethod(
    username,
    issueCode,
    moduleName,
    description,
    image,
  ) async {
    _isDataLoading = true;
    //final asg = issuecode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String urlActivities = '$base_url_v1$TOKEN_V1$deviceToken&action=addAttachment&issueCode=$issueCode&username=$username&moduleName=$moduleName';

    print('photoAdressssMethod$urlActivities');

    final result = await apirepository.addAttachment(controller: urlActivities, description: description, image: image);

    print('photoAdress2${result.records['result']}');

    if (true) {
      Future.delayed(const Duration(milliseconds: 0), () {
        _isPhotoAddSuccess = result.records['result'].toString();
        _isDataLoading = false;
        _loading = false;
        _isDataExist = false;
        _isDescriptionLengthSuccess = true;

        notifyListeners();
        _currentPage = 1;
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }

  void initData([PageController? pageController]) {
    _pageController = pageController;
  }
}
