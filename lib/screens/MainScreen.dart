import 'package:alif_hw_pi/screens/DimensionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../widgets/AppDrawer.dart';

class MainScreen extends StatefulWidget {
  static const id = '/MainScreen';
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController billName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alif PI', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Invoice Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: billName,
                      decoration: InputDecoration(
                        hintText: "Enter Customer Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
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
      )
    );
  }
}


