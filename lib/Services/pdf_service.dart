import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService{
  Future<Uint8List> generatePdf(String billName,List<Map<String, dynamic>> tableValues)async{
    final pdf = pw.Document();
    num totalAmount =0;
    List<pw.Widget> pageWidgets = [];
    final logo =
    (await rootBundle.load("assets/images/logo.png")).buffer.asUint8List();
    final logoArea = pw.Container(
        height: 60,
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        padding: const pw.EdgeInsets.all(2),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(
                padding: const pw.EdgeInsets.only(right: 2),
                decoration: const pw.BoxDecoration(
                    border: pw.Border(right: pw.BorderSide())),
                child: pw.Image(pw.MemoryImage(logo))),
            pw.Expanded(
                child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Column(
                      children: [
                        pw.Expanded(
                            child: pw.Text("A.S. GLASS HARDWARE",
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold))),
                        pw.SizedBox(height: 20),
                        pw.Expanded(
                            child: pw.Text(
                                "Address: Plot no. D-83, SUPA MIDC, Tal. Parner, Dist. Ahmednagar, Pincode: 414301",
                                style: const pw.TextStyle(fontSize: 10))),
                        pw.SizedBox(height: 8),
                        pw.Expanded(
                            child: pw.Text(
                                "Contact No. 9657895687",
                                style: const pw.TextStyle(fontSize: 10))),
                      ],
                    ))),
          ],
        ));
    final title = pw.Container(
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                right: pw.BorderSide(),
                left: pw.BorderSide(),
                bottom: pw.BorderSide())),
        child: pw.Center(
            child: pw.Text("PROFORMA INVOICE",
                style: pw.TextStyle(
                    fontSize: 11, fontWeight: pw.FontWeight.bold))));

    final title2 = pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Expanded(
                    child: pw.Text("Customer Name: $billName",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Expanded(
                    child: pw.Text(
                        "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        style: const pw.TextStyle(fontSize: 10)))),
          ],
        ));

    pw.Padding blankCell() {
      return pw.Padding(padding: const pw.EdgeInsets.all(2));
    }

    pw.Padding textCell(String text) {
      return pw.Padding(
          padding: const pw.EdgeInsets.all(2),
          child: pw.Center(child: pw.Text(text, style: const pw.TextStyle(fontSize: 10))));
    }
    pw.Padding textCellBold(String text) {
      return pw.Padding(
          padding: const pw.EdgeInsets.all(2),
          child: pw.Center(
              child: pw.Text(text,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))));
    }


    pw.Table table() {
      List<pw.TableRow> rows = [];

      for (var value in tableValues) {
        print(value);
        totalAmount+=num.parse(value["amount"]);
        rows.add(pw.TableRow(
          children: [
            textCell(value["sr"].toString()),
            textCell(value["title"]),
            textCell(value["size"]),
            textCell(value["rate"]),
            textCell(value["qty"]),
            textCell(value["amount"]),
          ],
        ));
      }
      return pw.Table(
        columnWidths: {
          0: const pw.FixedColumnWidth(75.0),
          1: const pw.FixedColumnWidth(150.0),
          2: const pw.FixedColumnWidth(85.0),
          3: const pw.FixedColumnWidth(85.0),
          4: const pw.FixedColumnWidth(50.0),
          5: const pw.FixedColumnWidth(100.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              textCellBold("Sr"),
              textCellBold("NAME OF MATERIAL"),
              textCellBold("SIZE"),
              textCellBold("QTY"),
              textCellBold("RATE"),
              textCellBold("AMOUNT"),
            ],
          ),
          ...rows,
          pw.TableRow(children: [
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            textCellBold("TOTAL"),
            textCellBold(totalAmount.toString()),
          ]),
        ],
      );
    }

    pageWidgets.add(logoArea);
    pageWidgets.add(title);
    pageWidgets.add(title2);
    pageWidgets.add(table());


    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48),
        build: (pw.Context content) {
          return pageWidgets;
        }));

    return pdf.save();
  }
}