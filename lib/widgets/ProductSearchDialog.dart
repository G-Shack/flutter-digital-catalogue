import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/table_values_provider.dart';
import '../model/product_model.dart';
import 'DimensionButton.dart';

class ProductSearchDialog extends StatefulWidget {
  final List<Product> availProducts;
  final int tableIndex;
  const ProductSearchDialog({super.key, required this.availProducts, required this.tableIndex});

  @override
  State<ProductSearchDialog> createState() => _ProductSearchDialogState();
}

class _ProductSearchDialogState extends State<ProductSearchDialog> {
  List<Product> tempAvailProducts = [];

  int tableIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tableIndex = widget.tableIndex;
    tempAvailProducts = widget.availProducts; // Initialize with all products
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Product',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search Product',
              border: OutlineInputBorder(),
            ),
            onChanged: (query) {
              setState(() {
                tempAvailProducts = widget.availProducts.where((product) {
                  final prodTitle = product.title.toLowerCase();
                  final input = query.toLowerCase();
                  return prodTitle.contains(input);
                }).toList();
              });
            },
          ),
          Expanded(
            child: tempAvailProducts.isNotEmpty?
            ListView.builder(
              itemCount: tempAvailProducts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Image.asset(
                      tempAvailProducts[index].image,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(tempAvailProducts[index].title, style: const TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(
                      'Rate:${tempAvailProducts[index].rate}   Size:${tempAvailProducts[index].size}',
                    ),
                    onTap: (){
                      context.read<TableValuesProvider>().updateRow(
                        tableIndex,
                        tempAvailProducts[index].title,
                        tempAvailProducts[index].image,
                        tempAvailProducts[index].size,
                        tempAvailProducts[index].rate,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ):const Text(
              '\nNo results found',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20.0),
          DimensionButton(
            btnTxt: 'Cancel',
            fun: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
