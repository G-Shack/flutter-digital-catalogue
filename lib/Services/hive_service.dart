import 'package:hive/hive.dart';

class HiveService {
  final _recentPiBox = Hive.box('recent_pi_box');
  Future<int> createItem(
      List<Map<String, dynamic>> tableValues, String billName) async {
    // Check if bill name already exists
    final existingKey = _recentPiBox.keys.firstWhere(
        (key) => _recentPiBox.get(key)['piName'] == billName,
        orElse: () => null);

    if (existingKey != null) {
      final existingItem = _recentPiBox.get(existingKey);
      existingItem['tableValues'] = tableValues;
      existingItem['date'] = DateTime.now();
      await _recentPiBox.put(existingKey, existingItem);
      return existingItem['piNo'] as int;
    } else {
      int largestPiNo = 0;
      for (var item in _recentPiBox.values) {
        final piNo = item['piNo'];
        try {
          final piNoInt = piNo;
          if (piNoInt > largestPiNo) {
            largestPiNo = piNoInt;
          }
        } catch (e) {
          print('Error parsing piNo: $e');
        }
      }
      int piNo = largestPiNo + 1;
      Map<String, dynamic> piValues = {};
      piValues.addAll({
        'piNo': piNo,
        'piName': billName,
        'date': DateTime.now(),
        'tableValues': tableValues
      });
      await _recentPiBox.add(piValues);
      return piNo;
    }
  }

  List<Map<String, dynamic>> refreshItems() {
    final now = DateTime.now();
    final xMonthsAgo = now.subtract(const Duration(days: 366));

    final data = _recentPiBox.keys
        .map((key) {
          final piValue = _recentPiBox.get(key);
          final itemDate = piValue['date'] as DateTime;

          if (itemDate.isBefore(xMonthsAgo)) {
            _recentPiBox.delete(key);
            return null;
          } else {
            return {
              "key": key,
              "piNo": piValue['piNo'],
              "piName": piValue['piName'],
              "date": piValue['date'],
              "tableValues": piValue['tableValues']
            };
          }
        })
        .whereType<Map<String, dynamic>>()
        .toList();
    return data.reversed.toList();
  }

  Future<void> deleteItem(int piNo) async {
    final key = _recentPiBox.keys.firstWhere(
        (key) => _recentPiBox.get(key)['piNo'] == piNo,
        orElse: () => null);

    if (key != null) {
      await _recentPiBox.delete(key);
    } else {
      print('Item with piNo $piNo not found in the box.');
    }
  }
}
