import 'package:alif_hw_pi/Provider/table_values_provider.dart';
import 'package:alif_hw_pi/Services/hive_service.dart';
import 'package:alif_hw_pi/widgets/InvoiceTable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/pdf_service.dart';

class DimensionPage extends StatelessWidget {
  final String billName;
  DimensionPage({super.key, required this.billName});

  final PdfService pdfService = PdfService();
  final HiveService hiveService = HiveService();

  @override
  Widget build(BuildContext context) {
    return Consumer<TableValuesProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('A.S. Hardware PI'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer Name: $billName',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<TableValuesProvider>(
                    builder: (context, tableValuesProvider, child) {
                      return InvoiceTable(
                        initialTableValues: tableValuesProvider.tableValues,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xCD000000),
          child: const Icon(
            Icons.save,
            color: Colors.amber,
          ),
          onPressed: () async {
            var tableValues = provider.tableValues;
            int piNo = await hiveService.createItem(tableValues, billName);
            final bill =
                await pdfService.generatePdf(billName, tableValues, piNo);
            pdfService.savePdf('PI Bill $billName', bill);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => PdfPreviewPage(
            //       bill: bill,
            //       billName: billName,
            //     ),
            //   ),
            // );
          },
        ),
      );
    });
  }
}
