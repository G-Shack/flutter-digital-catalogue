import 'package:alif_hw_pi/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/product_list_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const id = '/ProductDetailsPage';
  final Product theProduct;
  const ProductDetailsPage({super.key, required this.theProduct});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.theProduct.title);
    TextEditingController rateController =
        TextEditingController(text: widget.theProduct.rate);
    TextEditingController sizeController =
        TextEditingController(text: widget.theProduct.size);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () {
                int productIndex =
                    context.read<Products>().availProducts.indexWhere(
                          (product) => product.id == widget.theProduct.id,
                        );
                if (productIndex != -1) {
                  context.read<Products>().deleteRow(productIndex);
                  Navigator.pop(context);
                } else {
                  print('Product not found!');
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ))
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.asset(widget.theProduct.image)),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    label: Text('Product Name'),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: rateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Rate'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: sizeController,
                        decoration: const InputDecoration(
                          label: Text('Size'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    String updatedTitle = titleController.text;
                    String updatedRate = rateController.text;
                    String updatedSize = sizeController.text;
                    int productIndex =
                        context.read<Products>().availProducts.indexWhere(
                              (product) => product.id == widget.theProduct.id,
                            );

                    // 3. Update the product in the provider (if found)
                    if (productIndex != -1) {
                      context.read<Products>().updateRow(
                          productIndex, updatedTitle, updatedSize, updatedRate);
                      Navigator.pop(context);
                    } else {
                      // Handle the case where the product is not found
                      print('Product not found!');
                    }
                  },
                  style: ButtonStyle(
                    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                    backgroundColor:
                        WidgetStateColor.resolveWith((states) => Colors.amber),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SAVE',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
