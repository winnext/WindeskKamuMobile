import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageViewProvider extends ChangeNotifier {



        bool _password_visible = true;
        bool  get password_visible => _password_visible;

        String _kadi = '';
        String get kadi => _kadi;
     set setVisible(bool password_visible ){
        _password_visible = password_visible;
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

  void initForm() async{
    _pageController = PageController();
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("prefsUserName"));
    _kadi = prefs.getString('prefsUserName') ?? '';

  }
}
