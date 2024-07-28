import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_model.dart';

class Products with ChangeNotifier{
  List<Product> _availProducts = [
   Product(id: '1', title: 'Floor Hinge 8400 150 Kgs', description: 'AFS-8400, Double Spring Floor Hinge', image: 'assets/product_images/AFS-8400.png', size: 'One Size', rate: '1'),
   Product(id: '2', title: 'Floor Hinge 7400 90 Kgs', description: 'AFS-7400, Single Spring Floor Hinge', image: 'assets/product_images/AFS-7400.png', size: 'One Size', rate: '1'),
   Product(id: '3', title: 'Floor Hinge 8400 55 Kgs', description: 'AFS-6400, Double Spring Floor Hinge', image: 'assets/product_images/AFS-6400.png', size: 'One Size', rate: '1'),
   Product(id: '4', title: 'Top/Bottom Pivot', description: 'AFS-ACC-TP_BP', image: 'assets/product_images/AFS-ACC-TP_BP.png', size: 'One Size', rate: '1'),
   Product(id: '5', title: 'Floor Hinge 8400 150Kgs Set', description: 'AFS-8400, Double Spring Floor Hinge Combo/Set', image: 'assets/product_images/AFS-8400Combo.png', size: 'Combo', rate: '1'),
   Product(id: '6', title: 'Floor Hinge 7400 90Kgs Set', description: 'AFS-7400, Double Spring Floor Hinge Combo/Set', image: 'assets/product_images/AFS-7400Combo.png', size: 'Combo', rate: '1'),
   Product(id: '7', title: 'Hydraulic Floor Hinge', description: 'AHFS-100, Hydraulic Floor Hinge', image: 'assets/product_images/AHFS-100.png', size: 'One Size', rate: '1'),
   Product(id: '8', title: 'Hydraulic Floor Hinge Set', description: 'AHFS-100, Hydraulic Floor Hinge Combo/Set', image: 'assets/product_images/AHFS-100Set.png', size: 'Combo', rate: '1'),
   Product(id: '9', title: 'Big L', description: 'APF-40, Patch Fittings', image: 'assets/product_images/APF-40.png', size: 'One Size', rate: '1'),
   Product(id: '10', title: 'Small L', description: 'APF-610, Patch Fittings', image: 'assets/product_images/APF-610.png', size: 'One Size', rate: '1'),
   Product(id: '11', title: 'Over Panel', description: 'APF-511, Patch Fittings', image: 'assets/product_images/APF-511.png', size: 'One Size', rate: '1'),
   Product(id: '12', title: 'Glass to Glass Connecting', description: 'APF-650, Patch Fittings', image: 'assets/product_images/APF-650.png', size: 'One Size', rate: '1'),
   Product(id: '13', title: 'Wall to Glass Connecting', description: 'APF-640, Patch Fittings', image: 'assets/product_images/APF-640.png', size: 'One Size', rate: '1'),
   Product(id: '14', title: 'U Connector Box', description: 'AGC-1, Glass Connectors', image: 'assets/product_images/AGC-1.png', size: 'One Size', rate: '1'),
   Product(id: '15', title: 'U Connector Round', description: 'AGC-1R, Glass Connectors', image: 'assets/product_images/AGC-1R.png', size: 'One Size', rate: '1'),
   Product(id: '16', title: 'GlassToGlass 135°', description: 'AGC-2, Glass Connectors', image: 'assets/product_images/AGC-2.png', size: 'One Size', rate: '1'),
   Product(id: '17', title: 'GlassToGlass 135° Round', description: 'AGC-2R, Glass Connectors', image: 'assets/product_images/AGC-2R.png', size: 'One Size', rate: '1'),
   Product(id: '18', title: 'GlassToGlass 90°', description: 'AGC-3, Glass Connectors', image: 'assets/product_images/AGC-3.png', size: 'One Size', rate: '1'),
   Product(id: '19', title: 'GlassToGlass 90° Round', description: 'AGC-3R, Glass Connectors', image: 'assets/product_images/AGC-3R.png', size: 'One Size', rate: '1'),
   Product(id: '20', title: 'GlassToGlass 180°', description: 'AGC-5, Glass Connectors', image: 'assets/product_images/AGC-5.png', size: 'One Size', rate: '1'),
   Product(id: '21', title: 'GlassToGlass 180° Round', description: 'AGC-5R, Glass Connectors', image: 'assets/product_images/AGC-5R.png', size: 'One Size', rate: '1'),
   Product(id: '22', title: 'L Connector', description: 'AGC-4, Glass Connectors', image: 'assets/product_images/AGC-4.png', size: 'One Size', rate: '1'),
   Product(id: '23', title: 'L Connector Round', description: 'AGC-4R, Glass Connectors', image: 'assets/product_images/AGC-4R.png', size: 'One Size', rate: '1'),
   Product(id: '24', title: 'GlassToGlass 90° T-Conn', description: 'AGC-6, Glass Connectors', image: 'assets/product_images/AGC-6.png', size: 'One Size', rate: '1'),
   Product(id: '25', title: 'WallToGlass 90° OffSet Hinge', description: 'ASH-1H_P, Shower Hinges', image: 'assets/product_images/ASH-1H_P.png', size: 'One Size', rate: '1'),
   Product(id: '26', title: 'WallToGlass 90° Hinge', description: 'ASH-1, Shower Hinges', image: 'assets/product_images/ASH-1.png', size: 'One Size', rate: '1'),
   Product(id: '27', title: 'GlassToGlass 180° Hinge', description: 'ASH-2, Shower Hinges', image: 'assets/product_images/ASH-2.png', size: 'One Size', rate: '1'),
   Product(id: '28', title: 'GlassToGlass 135° Hinge', description: 'ASH-3, Shower Hinges', image: 'assets/product_images/ASH-3.png', size: 'One Size', rate: '1'),
   Product(id: '29', title: 'GlassToGlass 90° Hinge', description: 'ASH-4, Shower Hinges', image: 'assets/product_images/ASH-4.png', size: 'One Size', rate: '1'),
   Product(id: '30', title: 'WallToGlass 90° Fix Brkt', description: 'ASH-5, Shower Hinges', image: 'assets/product_images/ASH-5.png', size: 'One Size', rate: '1'),
   Product(id: '31', title: 'Wall Seal 8mm', description: 'APS-1, 8mm, 2.2mtr, Plastic Profiles', image: 'assets/product_images/APS-1.png', size: '8mm (2.2mtr.)', rate: '1'),
   Product(id: '32', title: 'Wall Seal 10mm', description: 'APS-1, 10mm, 2.2mtr, Plastic Profiles', image: 'assets/product_images/APS-1.png', size: '10mm (2.2mtr.)', rate: '1'),
   Product(id: '33', title: 'Wall Seal 12mm', description: 'APS-1, 12mm, 2.2mtr, Plastic Profiles', image: 'assets/product_images/APS-1.png', size: '12mm (2.2mtr.)', rate: '1'),
   Product(id: '34', title: 'D Seal 8mm', description: 'APS-4, 8mm, 2.2mtr, Plastic Profiles', image: 'assets/product_images/APS-4DSeal.png', size: '8mm (2.2mtr.)', rate: '1'),
   Product(id: '35', title: 'D Seal 10mm', description: 'APS-4, 10mm, 2.2mtr, Plastic Profiles', image: 'assets/product_images/APS-4DSeal.png', size: '10mm (2.2mtr.)', rate: '1'),
   Product(id: '36', title: 'D Seal 12mm', description: 'APS-4, 12mm, 2.2mtr, Plastic Profiles', image: 'assets/product_images/APS-4DSeal.png', size: '12mm (2.2mtr.)', rate: '1'),
   Product(id: '37', title: 'D Seal 10mm', description: 'APS-4, 10mm, 2.5mtr, Plastic Profiles', image: 'assets/product_images/APS-4DSeal.png', size: '10mm (2.5mtr.)', rate: '1'),
   Product(id: '38', title: 'D Seal 12mm', description: 'APS-4, 12mm, 2.5mtr, Plastic Profiles', image: 'assets/product_images/APS-4DSeal.png', size: '12mm (2.5mtr.)', rate: '1'),
   Product(id: '39', title: 'WallToRod Head', description: 'AKH-1, Shower Knight Head Accessories', image: 'assets/product_images/AKH-1.png', size: 'One Size', rate: '1'),
   Product(id: '40', title: 'RodToGlass Head', description: 'AKH-2, Shower Knight Head Accessories', image: 'assets/product_images/AKH-2.png', size: 'One Size', rate: '1'),
   Product(id: '41', title: 'RodToRod Head', description: 'AKH-3, Shower Knight Head Accessories', image: 'assets/product_images/AKH-3.png', size: 'One Size', rate: '1'),
   Product(id: '42', title: 'RodToGlass Head(Blind)', description: 'AKH-4, Shower Knight Head Accessories', image: 'assets/product_images/AKH-4.png', size: 'One Size', rate: '1'),
   Product(id: '43', title: 'RodToRod Head(T-Conn)', description: 'AKH-5, Shower Knight Head Accessories', image: 'assets/product_images/AKH-5.png', size: 'One Size', rate: '1'),
   Product(id: '44', title: 'Sliding Roller', description: 'ASL-11-A1, Shower Sliding System 11A', image: 'assets/product_images/ASL-11-A1.png', size: '2 Pcs', rate: '1'),
   Product(id: '45', title: 'TrackToGlass Holder', description: 'ASL-11-A2, Shower Sliding System 11A', image: 'assets/product_images/ASL-11-A2.png', size: '2 Pcs', rate: '1'),
   Product(id: '46', title: 'Stopper', description: 'ASL-11-A3, Shower Sliding System 11A', image: 'assets/product_images/ASL-11-A3.png', size: '2 Pcs', rate: '1'),
   Product(id: '47', title: 'Floor Guide', description: 'ASL-11-A4, Shower Sliding System 11A', image: 'assets/product_images/ASL-11-A4.png', size: '1 Pcs', rate: '1'),
   Product(id: '48', title: 'WallToTrack Connector', description: 'ASL-11-A5, Shower Sliding System 11A', image: 'assets/product_images/ASL-11-A5.png', size: '2 Pcs', rate: '1'),
   Product(id: '49', title: 'Sliding Handle', description: 'ASL-HN-50, Shower Sliding System 11A', image: 'assets/product_images/ASL-HN-50.png', size: '1 Pcs', rate: '1'),
   Product(id: '50', title: 'Roller (S.S.) Set', description: 'ASL-44-A1, Sliding System Set', image: 'assets/product_images/ASL-44-A1Set.png', size: 'Combo', rate: '1'),
   Product(id: '51', title: 'Roller (Brass) Set', description: 'ABSL-44-A2, Sliding System Set', image: 'assets/product_images/ABSL-44-A2Set.png', size: 'Combo', rate: '1'),
   Product(id: '52', title: 'Track Sliding Set', description: 'CD-44, Curve Track Sliding Set', image: 'assets/product_images/CD-44Set.png', size: 'Combo', rate: '1'),
   Product(id: '53', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '25x212x325', rate: '1'),
   Product(id: '54', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '25x240x325', rate: '1'),
   Product(id: '55', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '32x302x450', rate: '1'),
   Product(id: '56', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '32x450x600', rate: '1'),
   Product(id: '57', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '32x600x900', rate: '1'),
   Product(id: '58', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '32x700x900', rate: '1'),
   Product(id: '59', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '32x900x1200', rate: '1'),
   Product(id: '60', title: 'Door Handle 104', description: 'ADH-104, Door Handles', image: 'assets/product_images/ADH-104.png', size: '32x1200x1500', rate: '1'),
   Product(id: '61', title: 'Door Handle 11', description: 'ADH-11, Door Handles', image: 'assets/product_images/ADH-11.png', size: '25x302x327', rate: '1'),
   Product(id: '62', title: 'Door Handle 11', description: 'ADH-11, Door Handles', image: 'assets/product_images/ADH-11.png', size: '32x450x482', rate: '1'),
   Product(id: '63', title: 'Door Handle 77', description: 'ACDH-77, Door Handles', image: 'assets/product_images/ACDH-77.png', size: '23x302x450', rate: '1'),
   Product(id: '64', title: 'Door Handle 2068', description: 'ADH-2068, Door Handles', image: 'assets/product_images/ADH-2068.png', size: '38/25x302x450', rate: '1'),
   Product(id: '65', title: 'Door Handle SS 177', description: 'ADH-177, SS, Door Handles', image: 'assets/product_images/ADH-177SS.png', size: '38x302x450', rate: '1'),
   Product(id: '66', title: 'Door Handle SS 177', description: 'ADH-177, SS, Door Handles', image: 'assets/product_images/ADH-177SS.png', size: '38x450x600', rate: '1'),
   Product(id: '67', title: 'Door Handle 2029', description: 'ADH-2029, Door Handles', image: 'assets/product_images/ADH-2029.png', size: '25/45x302x450', rate: '1'),
   Product(id: '68', title: 'Door Handle 2029', description: 'ADH-2029, Door Handles', image: 'assets/product_images/ADH-2029.png', size: '25/45x450x600', rate: '1'),
   Product(id: '69', title: 'Door Handle Acrylic 901', description: 'ADH-901, Acrylic, Door Handles', image: 'assets/product_images/ADH-901.png', size: '38x302x450', rate: '1'),
   Product(id: '70', title: 'Door Handle Acrylic 901', description: 'ADH-901, Acrylic, Door Handles', image: 'assets/product_images/ADH-901.png', size: '38x450x600', rate: '1'),
   Product(id: '71', title: 'Door Knob', description: 'ADK-1, Door Knob', image: 'assets/product_images/ADK-1.png', size: 'One Size', rate: '1'),
   Product(id: '72', title: 'Door Knob', description: 'ADK-2, Door Knob', image: 'assets/product_images/ADK-2.png', size: 'One Size', rate: '1'),
   Product(id: '73', title: 'Door Knob', description: 'ADK-3, Door Knob', image: 'assets/product_images/ADK-3.png', size: 'One Size', rate: '1'),
   Product(id: '74', title: 'Door Knob', description: 'ADK-4, Door Knob', image: 'assets/product_images/ADK-4.png', size: 'One Size', rate: '1'),
   Product(id: '75', title: 'Shower Handle 1', description: 'ADH-TB-01, Door Knob', image: 'assets/product_images/ADH-TB-01.png', size: '19x152x457CC', rate: '1'),
   Product(id: '76', title: 'Shower Handle 1', description: 'ADH-TB-01, Door Knob', image: 'assets/product_images/ADH-TB-01.png', size: '25x152x457CC', rate: '1'),
   Product(id: '77', title: 'Shower Handle 2', description: 'ADH-TB-02, Door Knob', image: 'assets/product_images/ADH-TB-02.png', size: '15/30x152x457', rate: '1'),
   Product(id: '78', title: 'Double Door Lock', description: 'ALK-1, Locks', image: 'assets/product_images/ALK-1.png', size: 'Key', rate: '1'),
   Product(id: '79', title: 'Single Door Lock', description: 'ALK-2, Locks', image: 'assets/product_images/ALK-2.png', size: 'Key', rate: '1'),
   Product(id: '80', title: 'Double Door Lock', description: 'ALK-3, Locks', image: 'assets/product_images/ALK-3.png', size: 'Key+Knob', rate: '1'),
   Product(id: '81', title: 'Single Door Lock', description: 'ALK-4, Locks', image: 'assets/product_images/ALK-4.png', size: 'Key+Knob', rate: '1'),
   Product(id: '82', title: 'Mini Double Door Lock (Slot)', description: 'ALK-9, Locks', image: 'assets/product_images/ALK-9.png', size: 'Key+Knob', rate: '1'),
   Product(id: '83', title: 'Mini Single Door Lock (Slot)', description: 'ALK-10, Locks', image: 'assets/product_images/ALK-10.png', size: 'Key+Knob', rate: '1'),
   Product(id: '84', title: 'Mini Double Door Lock (Pin)', description: 'ALK-11, Locks', image: 'assets/product_images/ALK-11.png', size: 'Key+Knob', rate: '1'),
   Product(id: '85', title: 'Mini Single Door Lock (Pin)', description: 'ALK-12, Locks', image: 'assets/product_images/ALK-12.png', size: 'Key+Knob', rate: '1'),
   Product(id: '86', title: 'Double Door Lock', description: 'ALK-13, Locks', image: 'assets/product_images/ALK-13.png', size: 'Knob', rate: '1'),
   Product(id: '87', title: 'Single Door Lock', description: 'ALK-14, Locks', image: 'assets/product_images/ALK-14.png', size: 'Knob', rate: '1'),
   Product(id: '88', title: 'Double Door Lock', description: 'ALK-138A, Locks', image: 'assets/product_images/ALK-138A.png', size: 'Knob', rate: '1'),
   Product(id: '89', title: 'Single Door Lock', description: 'ALK-138B, Locks', image: 'assets/product_images/ALK-138B.png', size: 'Knob', rate: '1'),
   Product(id: '90', title: 'Railing Spigot ARA-2', description: 'ARA-2, Railings, Spigot', image: 'assets/product_images/ARA-2(Spigot).png', size: 'One Size', rate: '1'),
   Product(id: '91', title: 'Railing Mini ARA-2', description: 'ARA-2, Railings, Mini', image: 'assets/product_images/ARA-2(Mini).png', size: 'One Size', rate: '1'),
   Product(id: '92', title: 'Railing Spigot ARA-3', description: 'ARA-3, Railings, Spigot', image: 'assets/product_images/ARA-3(Spigot).png', size: 'One Size', rate: '1'),
   Product(id: '93', title: 'Railing Spigot ARA-222', description: 'ARA-222, Railings, Spigot', image: 'assets/product_images/ARA-222(Spigot).png', size: 'One Size', rate: '1'),
   Product(id: '94', title: 'Railing Spigot ARA-333', description: 'ARA-333, Railings, Spigot', image: 'assets/product_images/ARA-333(Spigot).png', size: 'One Size', rate: '1'),
   Product(id: '95', title: 'WallToHandrail', description: 'ARA-5, Railings', image: 'assets/product_images/ARA-5.png', size: 'One Size', rate: '1'),
   Product(id: '96', title: 'GlassToHandrail', description: 'ARA-6, Railings', image: 'assets/product_images/ARA-6.png', size: 'One Size', rate: '1'),
   Product(id: '97', title: 'GlassToHandrail', description: 'ARA-7, Railings', image: 'assets/product_images/ARA-7.png', size: 'One Size', rate: '1'),
   Product(id: '98', title: 'Railing Stud 45mm', description: 'ARA-9, Railings', image: 'assets/product_images/ARA-9.png', size: 'One Size', rate: '1'),
   Product(id: '99', title: 'Railing Stud 35mm', description: 'ARA-10, Railings', image: 'assets/product_images/ARA-10.png', size: 'One Size', rate: '1'),
   Product(id: '99', title: 'Glass Adjustable Stud', description: 'ARA-11, Railings', image: 'assets/product_images/ARA-11.png', size: 'One Size', rate: '1'),
   Product(id: '100', title: 'Glass Lifter 2 Cups', description: 'AGL-2C, Glass Lifter', image: 'assets/product_images/AGL-2C.png', size: 'One Size', rate: '1'),
   Product(id: '101', title: 'Glass Lifter 3 Cups', description: 'AGL-3C, Glass Lifter', image: 'assets/product_images/AGL-2C.png', size: 'One Size', rate: '1'),
  ];

  List<Product> get availProducts => _availProducts;

  void updateRow(int index, String title, String size, String rate){
    _availProducts[index] = Product(id: _availProducts[index].id, title: title, description: _availProducts[index].description, image: _availProducts[index].image, size: size, rate: rate);
    updateProducts();
    notifyListeners();
  }
  void addProduct(Product value){
    _availProducts.add(value);
    updateProducts();
    notifyListeners();
  }
  void deleteRow(int value){
    _availProducts.remove(_availProducts[value]);
    updateProducts();
    notifyListeners();
  }

  void loadProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var productsString = prefs.getString('productsString');

    if (productsString != null) {
      print('loaded: $productsString');
      var productsJson = jsonDecode(productsString) as List;
      List<Product> fetchAvailProducts = productsJson.map((productJson) {
        return Product(
          id: productJson['id'],
          title: productJson['title'],
          description: productJson['description'],
          image: productJson['image'],
          rate: productJson['rate'],
          size: productJson['size'],
        );
      }).toList();
      if(!listEquals(fetchAvailProducts, _availProducts)){
        _availProducts = fetchAvailProducts.length>_availProducts.length?fetchAvailProducts:_availProducts;
      }
    } else {
      // Convert each Product to a Map using toJson
      var productsJson = _availProducts.map((product) => product.toJson()).toList();
      var isSet = prefs.setString('productsString', jsonEncode(productsJson));
      print('Set First item $isSet');
    }
    notifyListeners();
  }

  void updateProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final updatedProducts = availProducts;

    // Convert each Product to a Map using toJson
    var productsJson = updatedProducts.map((product) =>product.toJson()).toList();

    // Save the updated products to SharedPreferences
    await prefs.setString('productsString', jsonEncode(productsJson));
    print('Products updated in SharedPreferences');
  }

}