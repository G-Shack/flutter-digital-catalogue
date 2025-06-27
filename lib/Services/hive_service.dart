import 'package:hive/hive.dart';

class HiveService {
  final _recentPiBox = Hive.box('recent_pi_box');
  final _counterBox = Hive.box('counter_box');

  Box getCounterBox() {
    return _counterBox;
  }

  int getNextPiNumber() {
    int currentCounter = _counterBox.get('piCounter', defaultValue: 0);
    int nextPiNo = currentCounter + 1;
    _counterBox.put('piCounter', nextPiNo);
    return nextPiNo;
  }

  Future<int> createNewPi(String piName) async {
    int piNo = getNextPiNumber();

    Map<String, dynamic> piData = {
      'piNo': piNo,
      'piName': piName,
      'date': DateTime.now(),
      'tableValues': <Map<String, dynamic>>[], // Initialize with empty table
    };

    await _recentPiBox.put(piNo, piData);
    return piNo;
  }

  Future<void> updatePi(int piNo, List<Map<String, dynamic>> tableValues,
      {String? piName}) async {
    final existingData = _recentPiBox.get(piNo);
    if (existingData != null) {
      existingData['tableValues'] = tableValues;
      existingData['date'] = DateTime.now(); // Update last modified date
      if (piName != null) {
        existingData['piName'] = piName;
      }
      await _recentPiBox.put(piNo, existingData);
    }
  }

  Map<String, dynamic>? getPi(int piNo) {
    return _recentPiBox.get(piNo);
  }

  List<Map<String, dynamic>> refreshItems() {
    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 366));

    List<Map<String, dynamic>> validItems = [];
    List<int> keysToDelete = [];

    for (var key in _recentPiBox.keys) {
      final piValue = _recentPiBox.get(key);
      if (piValue != null) {
        final itemDate = piValue['date'] as DateTime;

        if (itemDate.isBefore(oneYearAgo)) {
          keysToDelete.add(key);
        } else {
          validItems.add({
            "piNo": piValue['piNo'],
            "piName": piValue['piName'],
            "date": piValue['date'],
            "tableValues": piValue['tableValues']
          });
        }
      }
    }

    // Delete expired items
    for (var key in keysToDelete) {
      _recentPiBox.delete(key);
    }

    // Sort by piNo in descending order (latest first)
    validItems.sort((a, b) => (b['piNo'] as int).compareTo(a['piNo'] as int));
    return validItems;
  }

  Future<void> deleteItem(int piNo) async {
    await _recentPiBox.delete(piNo);
  }
}
