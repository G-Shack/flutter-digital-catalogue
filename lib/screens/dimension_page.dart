import 'package:alif_hw_pi/Provider/table_values_provider.dart';
import 'package:alif_hw_pi/Services/hive_service.dart';
import 'package:alif_hw_pi/widgets/InvoiceTable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/pdf_service.dart';
import 'dart:async';

class DimensionPage extends StatefulWidget {
  final String billName;
  final int piNo;

  const DimensionPage({super.key, required this.billName, required this.piNo});

  @override
  State<DimensionPage> createState() => _DimensionPageState();
}

class _DimensionPageState extends State<DimensionPage> {
  final PdfService pdfService = PdfService();
  final HiveService hiveService = HiveService();
  Timer? _autoSaveTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSave();
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _saveCurrentState(); // Save one last time before disposing
    super.dispose();
  }

  void _startAutoSave() {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _saveCurrentState();
    });
  }

  void _saveCurrentState() {
    final provider = context.read<TableValuesProvider>();
    hiveService.updatePi(widget.piNo, provider.tableValues);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableValuesProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: () async {
          _saveCurrentState(); // Save before leaving
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('PI #${widget.piNo} - A.S. Hardware'),
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
                      'PI Number: ${widget.piNo}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Customer Name: ${widget.billName}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Consumer<TableValuesProvider>(
                      builder: (context, tableValuesProvider, child) {
                        return InvoiceTable(
                          initialTableValues: tableValuesProvider.tableValues,
                          piNo: widget
                              .piNo, // Pass piNo to InvoiceTable for auto-save
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
              Icons.picture_as_pdf,
              color: Colors.amber,
            ),
            onPressed: () async {
              // Save current state
              _saveCurrentState();

              var tableValues = provider.tableValues;
              final bill = await pdfService.generatePdf(
                  widget.billName, tableValues, widget.piNo);
              pdfService.savePdf('PI Bill ${widget.billName}', bill);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PDF generated and saved!')),
              );
            },
          ),
        ),
      );
    });
  }
}
