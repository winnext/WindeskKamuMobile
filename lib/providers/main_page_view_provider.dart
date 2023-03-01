import 'package:flutter/material.dart';

class MainPageViewProvider extends ChangeNotifier {

        bool _password_visible = true;
        bool  get password_visible => _password_visible;


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

  void initForm() {
    _pageController = PageController();
  }
}
