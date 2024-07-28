import 'package:alif_hw_pi/screens/dimension_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Provider/product_list_provider.dart';
import '../widgets/AppDrawer.dart';

class MainScreen extends StatefulWidget {
  static const id = '/MainScreen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController billName = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Products>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A.S. Hardware PI', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 70,),
                Material(
                  elevation: 15,
                  shadowColor: Colors.amberAccent,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    radius: (MediaQuery.of(context).size.width/2)-50,
                    backgroundImage: const AssetImage('assets/images/AlifLogo.png'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Invoice Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: billName,
                          decoration: const InputDecoration(
                            hintText: "Enter Customer Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if(billName.text!=""){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DimensionPage(billName: billName.text)));
                      }else{
                        Fluttertoast.showToast(msg: 'Customer Name Empty!');
                        FocusManager.instance.primaryFocus?.unfocus();
                      }

                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.amber),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          "PROCEED",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12)
              ],
            ),
          ),
        ),
      )
    );
  }
}


