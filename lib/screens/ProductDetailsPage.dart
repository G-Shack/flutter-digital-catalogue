import 'package:alif_hw_pi/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/ProductListProvider.dart';

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
    TextEditingController titleController = TextEditingController(text:widget.theProduct.title);
    TextEditingController rateController = TextEditingController(text: widget.theProduct.rate);
    TextEditingController sizeController = TextEditingController(text: widget.theProduct.size);
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product'),
        actions: [
        IconButton(onPressed: (){
          int productIndex = context.read<Products>().availProducts.indexWhere(
                (product) => product.id == widget.theProduct.id,
          );
          if (productIndex != -1) {
            context.read<Products>().deleteRow(productIndex);
            Navigator.pop(context);
          } else {
            print('Product not found!');
          }
        }, icon: Icon(Icons.delete, color: Colors.redAccent,))
      ],),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(width: 250,height: 250,child: Image.asset(widget.theProduct.image)),
                ),
               SizedBox(height: 30),
               TextFormField(
                 controller: titleController,
                  decoration: InputDecoration(
                    label: Text('Product Name'),
                  ),
               ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: TextFormField(
                      controller: rateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Rate'),
                      ),
                    ),),
                    SizedBox(width: 30,),
                    Expanded(child: TextFormField(
                      controller: sizeController,
                      decoration: InputDecoration(
                        label: Text('Size'),
                      ),
                    ),),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(onPressed: (){
                  String updatedTitle = titleController.text;
                  String updatedRate = rateController.text;
                  String updatedSize = sizeController.text;
                  int productIndex = context.read<Products>().availProducts.indexWhere(
                        (product) => product.id == widget.theProduct.id,
                  );

                  // 3. Update the product in the provider (if found)
                  if (productIndex != -1) {
                    context.read<Products>().updateRow(productIndex, updatedTitle, updatedSize, updatedRate);
                    Navigator.pop(context);
                  } else {
                    // Handle the case where the product is not found
                    print('Product not found!');
                  }
                },
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('SAVE',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ), style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.amber),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
