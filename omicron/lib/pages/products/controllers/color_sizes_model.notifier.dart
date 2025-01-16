import 'package:flutter/material.dart';

class ColorSizeModelNotifier with ChangeNotifier {
  String _size = "";
  String get size => _size;

  String _colors = "";
  String get colors => _colors;

  void setSize(String temp) {
    if (_size == temp) {
      _size = "";
    } else {
      _size = temp;
    }
    notifyListeners();
  }

  void setColors(String temp) {
    if (_colors == temp) {
      _colors = "";
    } else {
      _colors = temp;
    }
    notifyListeners();
  }
}
