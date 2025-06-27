import 'package:alif_hw_pi/Provider/table_values_provider.dart';
import 'package:flutter/material.dart';
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Products>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableValuesProvider>(builder: (context, provider, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('A.S. Hardware PI',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          drawer: const AppDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Material(
                      elevation: 15,
                      shadowColor: Colors.amberAccent,
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        radius: (MediaQuery.of(context).size.width / 2) - 50,
                        backgroundImage:
                            const AssetImage('assets/images/AlifLogo.png'),
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
                          const Text(
                            'Invoice Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
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
                        onPressed: () async {
                          // final _recentPiBox = Hive.box('recent_pi_box');
                          // _recentPiBox.clear();
                          if (billName.text.isEmpty) {
                            _showSnackBar('Customer Name Empty!');
                            FocusManager.instance.primaryFocus?.unfocus();
                            return;
                          }
                          provider.tableValues.clear();
                          Navigator.pushNamed(
                            context,
                            '/dimensions',
                            arguments: {
                              'billName': billName.text,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
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
          ));
    });
  }
}
