import 'package:flutter/material.dart';

class TableValuesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _tableValues = [];

  List<Map<String, dynamic>> get tableValues => _tableValues;
  void changeTableValues(List<Map<String, dynamic>> newTableValues) {
    _tableValues = newTableValues;
    notifyListeners();
  }
  void updateRow(int index, String title, String image, String size, String rate) {
    if (index >= 0 && index < tableValues.length) {
      _tableValues[index]['title'] = title;
      _tableValues[index]['image'] = image;
      _tableValues[index]['size'] = size;
      _tableValues[index]['rate'] = rate;
      notifyListeners(); // Notify listeners of the change
    }
  }
}