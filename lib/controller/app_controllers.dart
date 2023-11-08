import 'package:flutter/material.dart';

class AppControllerProvider extends ChangeNotifier {
  //defines textfield visiblity
  bool isVisible = false;

  void setTrue() {
    isVisible = true;
    notifyListeners();
  }

  void setFalse() {
    isVisible = false;
    notifyListeners();
  }

  //defines search bar visibility
  bool isSearchBarVisible = false;

  void changeSearchBarVisiblity() {
    isSearchBarVisible = !isSearchBarVisible;
    notifyListeners();
  }
}
