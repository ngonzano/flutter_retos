import 'package:flutter/foundation.dart';

class EnableButtonShopping with ChangeNotifier {
  bool _enableButtonShopping = false;

  bool get enableButtonShopping => _enableButtonShopping;

  void setBoolButton({required bool enableShopping}) {
    _enableButtonShopping = enableShopping;
    notifyListeners();
  }

  int _indexPage = 0;
  int get indexPage => _indexPage;

  void setIndex({required int index}) {
    _indexPage = index;
    notifyListeners();
  }
}
