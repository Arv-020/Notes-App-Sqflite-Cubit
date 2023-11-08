import 'package:flutter/material.dart';

class AppControllerProvider extends ChangeNotifier {
  //defines textfield visiblity
  bool isVisibile = false;

  void changeVisibility() {
    isVisibile = !isVisibile;
    notifyListeners();
  }

  //defines search bar visibility
  bool isSearchBarVisible = false;

  void changeSearchBarVisiblity() {
    isSearchBarVisible = !isSearchBarVisible;
    notifyListeners();
  }
}
