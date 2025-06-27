import 'package:alif_hw_pi/Provider/table_values_provider.dart';
import 'package:alif_hw_pi/Services/hive_service.dart';
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
  HiveService hiveService = HiveService();
  int nextPiNumber = 1;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _loadNextPiNumber() {
    final counterBox = hiveService.getCounterBox();
    int currentCounter = counterBox.get('piCounter', defaultValue: 0);
    setState(() {
      nextPiNumber = currentCounter + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Products>().loadProducts();
      _loadNextPiNumber();
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
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.1),
                              border: Border.all(color: Colors.amber),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              'PI #$nextPiNumber',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: billName,
                              decoration: const InputDecoration(
                                hintText: "Enter Customer Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (billName.text.isEmpty) {
                            _showSnackBar('Customer Name Empty!');
                            FocusManager.instance.primaryFocus?.unfocus();
                            return;
                          }

                          // Store the customer name before clearing
                          String customerName = billName.text;

                          // Create new PI immediately and get PI number
                          int piNo =
                              await hiveService.createNewPi(customerName);

                          // Clear table values for new PI
                          provider.tableValues.clear();

                          // Clear the text field and update next PI number
                          billName.clear();
                          _loadNextPiNumber();

                          Navigator.pushNamed(
                            context,
                            '/dimensions',
                            arguments: {
                              'billName':
                                  customerName, // Use stored name instead
                              'piNo': piNo,
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
                    const SizedBox(height: 25)
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
