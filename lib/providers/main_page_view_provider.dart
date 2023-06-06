import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/models/announcement.model.dart';

import '../api/api_repository.dart';
import '../utils/api_urls.dart';

class MainPageViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();

  List<AnnouncementViewModel> _announcementView = [];
  List<AnnouncementViewModel> tempannouncementView = [];

  bool _password_visible = true;
  bool get password_visible => _password_visible;

  String _kadi = '';
  String get kadi => _kadi;
  set setVisible(bool password_visible) {
    _password_visible = password_visible;
    notifyListeners();
  }

  bool _isDataLoading = true;
  bool _isDataExist = false;
  int _toplamKayitSayisi = 0;

  List<AnnouncementViewModel> get announcementView => _announcementView;
  set setiannouncementView(List<AnnouncementViewModel> announcementView) {
    _announcementView = announcementView;
    notifyListeners();
  }

  bool get isDataExist => _isDataExist;
  set setisDataExist(bool isDataExist) {
    _isDataExist = isDataExist;
    notifyListeners();
  }

  bool get isDataLoading => _isDataLoading;

  set setisDataLoading(bool isDataLoading) {
    _isDataLoading = isDataLoading;
    notifyListeners();
  }

  int get toplamKayitSayisi => _toplamKayitSayisi;

  set settoplamKayitSayisi(int toplamKayitSayisi) {
    _toplamKayitSayisi = toplamKayitSayisi;
    notifyListeners();
  }

  PageController? _pageController;
  int _currentIndex = 0;

  PageController? get pageController => _pageController;
  int get currentIndex => _currentIndex;

  set setcurrentIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

  set setpageController(PageController pageController) {
    _pageController = pageController;
    notifyListeners();
  }

  void initForm() async {
    _pageController = PageController();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("prefsUserName"));
    _kadi = prefs.getString('prefsUserName') ?? '';
  }

  void getAnnouncements(xusercode) async {
    _isDataLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    final urlIssueTypes =
        '${base_url_v1}${TOKEN_V1}${deviceToken}&action=getAnnouncements&username=${xusercode}';

    final result =
        await apirepository.getAnnouncements(controller: urlIssueTypes);

    if (true) {
      tempannouncementView = (result.records['records'] as List)
          .map((e) => AnnouncementViewModel.fromJson(e))
          .toList();
      Future.delayed(const Duration(milliseconds: 0), () {
        announcementView.addAll(tempannouncementView);
        settoplamKayitSayisi = announcementView.length;
        _isDataLoading = false;
        _isDataExist = false;
        notifyListeners();
      });
    } else {
      // baglantiHatasi(context, result.message);
    }
  }
}
