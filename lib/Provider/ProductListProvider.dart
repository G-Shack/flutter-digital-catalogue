import 'package:flutter/cupertino.dart';

import '../model/Product.dart';

class Products with ChangeNotifier{
  List<Product> _availProducts = [
    Product(title: 'AFS-8400', description: 'Double Spring Floor Hinge\nDoor Size:1300x2300mm\nDoor Weight: 120-150 Kgs.', image: 'assets/images/AFS-8400.png', rate: '1500.0', size: 'OneSize'),
    Product(title: 'AFS-6400', description: 'Double Spring Floor Hinge\nDoor Size:1300x2300mm\nDoor Weight: 120-150 Kgs.', image: 'assets/images/AFS-6400.png', rate: '1700.0', size: 'OneSize'),
    Product(title: 'AFS-7400', description: 'Double Spring Floor Hinge\nDoor Size:1300x2300mm\nDoor Weight: 120-150 Kgs.', image: 'assets/images/AFS-7400.png', rate: '1600.0',size: 'OneSize'),
  ];

  List<Product> get availProducts => _availProducts;


// void addProduct(value){
//   _availProducts.add(value);
//   notifyListeners();
// }
}