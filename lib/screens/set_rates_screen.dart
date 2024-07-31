import 'package:alif_hw_pi/Provider/product_list_provider.dart';
import 'package:alif_hw_pi/screens/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';

class SetRatesScreen extends StatefulWidget {
  static const id = '/SetRatesScreen';
  const SetRatesScreen({super.key});

  @override
  State<SetRatesScreen> createState() => _SetRatesScreenState();
}

class _SetRatesScreenState extends State<SetRatesScreen> {
  List<Product> _allProducts =[];
  List<Product> _foundProducts = [];
  @override
  initState() {
    _allProducts = context.read<Products>().availProducts;
    _foundProducts = _allProducts;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allProducts;
    } else {
      results = _allProducts
          .where((user) =>
          user.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundProducts = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Rates')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  labelText: 'Search', prefixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<Products>(builder: (context, products, child) {
              return Expanded(
                child: _foundProducts.isNotEmpty
                    ? ListView.builder(
                  itemCount: _foundProducts.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(_foundProducts[index].title),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Image.asset(
                        _foundProducts[index].image,
                        fit: BoxFit.fill,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      title: Text(_foundProducts[index].title, style:const TextStyle(fontWeight: FontWeight.bold
                      )),
                      subtitle: Text(
                          'Rate: ${_foundProducts[index].rate} \t \t Size: ${_foundProducts[index].size}',
                          style:const TextStyle(color: Colors.black)),
                      onTap: (){
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage(theProduct: _foundProducts[index])));
                      },
                    ),
                  ),
                )
                    : const Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
            );}
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        int lastProductIndex = (_allProducts.length)-1;
        int lastProductId = int.tryParse(_allProducts[lastProductIndex].id)??1000;
        Product newProduct = Product(id: '${lastProductId+1}', title: '', description: '', image: 'assets/images/noImage.png', size: '', rate: '');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage(theProduct: newProduct)));
        context.read<Products>().addProduct(newProduct);
        print(newProduct.id);
      },
      child: const Icon(Icons.add),),
    );
  }
}