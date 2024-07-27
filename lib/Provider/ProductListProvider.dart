import 'package:flutter/cupertino.dart';

import '../model/Product.dart';

class Products with ChangeNotifier{
  List<Product> _availProducts = [
    Product(id:'1',title: 'AFS-8400', description: 'Double Spring Floor Hinge\nDoor Size:1300x2300mm\nDoor Weight: 120-150 Kgs.', image: 'assets/images/AFS-8400.png', rate: '1500.0', size: 'OneSize'),
    Product(id:'2',title: 'AFS-6400', description: 'Double Spring Floor Hinge\nDoor Size:1300x2300mm\nDoor Weight: 120-150 Kgs.', image: 'assets/images/AFS-6400.png', rate: '1700.0', size: 'OneSize'),
    Product(id:'3',title: 'AFS-7400', description: 'Double Spring Floor Hinge\nDoor Size:1300x2300mm\nDoor Weight: 120-150 Kgs.', image: 'assets/images/AFS-7400.png', rate: '1600.0',size: 'OneSize'),
  ];

  List<Product> get availProducts => _availProducts;

  void updateRow(int index, String title, String size, String rate){
    _availProducts[index] = Product(id: _availProducts[index].id, title: title, description: _availProducts[index].description, image: _availProducts[index].image, size: size, rate: rate);
    notifyListeners();
  }
  void addProduct(Product value){
    _availProducts.add(value);
    notifyListeners();
  }
  void deleteRow(int value){
    _availProducts.remove(_availProducts[value]);
    notifyListeners();
  }
}