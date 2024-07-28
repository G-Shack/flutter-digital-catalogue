import 'package:alif_hw_pi/Provider/table_values_provider.dart';
import 'package:alif_hw_pi/widgets/IncoiceTable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/pdf_service.dart';
import 'pdf_preview_page.dart';


class DimensionPage extends StatelessWidget {
  final String billName;
  DimensionPage({super.key, required this.billName});
  final PdfService pdfService = PdfService();
  @override
  Widget build(BuildContext context) {
    return Consumer<TableValuesProvider>(builder: (context, provider, child) {
    return Scaffold(
      appBar: AppBar(title: const Text('A.S. Hardware PI'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name: $billName', style: const TextStyle(fontSize: 18),),
                const SizedBox(height: 10,),
                const InvoiceTable(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xCD000000),
        child: const Icon(Icons.save, color: Colors.amber,),
        onPressed: () async {
          var tableValues = provider.tableValues;
          final bill =
          await pdfService.generatePdf(billName, tableValues);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(
                bill: bill,
                billName: billName,
              ),
            ),
          );
        },
      ),
    );
  });
  }
}
