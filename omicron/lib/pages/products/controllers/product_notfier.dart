import 'package:flutter/material.dart';
import 'package:omicron/pages/products/models/products_model.dart';

class ProductNotfier with ChangeNotifier {
  Products? product;

  void setProduct(Products temp) {
    product = temp;
    notifyListeners();
  }

  bool _description = false;
  bool get description => _description;

  void setDescription() {
    _description = !_description;
    notifyListeners();
  }

  void resetDescription() {
    _description = false;
    // notifyListeners();
  }
}
