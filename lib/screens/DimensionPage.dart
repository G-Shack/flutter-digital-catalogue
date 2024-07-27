import 'package:alif_hw_pi/widgets/IncoiceTable.dart';
import 'package:flutter/material.dart';

class DimensionPage extends StatelessWidget {
  final String billName;
  const DimensionPage({super.key, required this.billName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alif PI'),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name: $billName', style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                InvoiceTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
