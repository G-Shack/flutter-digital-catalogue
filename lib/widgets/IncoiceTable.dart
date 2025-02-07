import 'package:alif_hw_pi/widgets/CustomTableCell.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Provider/product_list_provider.dart';
import '../Provider/table_values_provider.dart';
import 'DimensionButton.dart';
import 'ProductSearchDialog.dart';


class InvoiceTable extends StatefulWidget {
  const InvoiceTable({super.key});

  @override
  State<InvoiceTable> createState() => _InvoiceTableState();
}

class _InvoiceTableState extends State<InvoiceTable> {

  void addRow() {
    final tableValuesProvider = context.read<TableValuesProvider>();
    tableValues.add({
      'image': 'assets/images/noImage.png',
      'title': '',
      'size': 'na',
      'rate': '1',
      'qty': '1',
      'amount': '',
    });
    tableValuesProvider.changeTableValues(tableValues);
    print(tableValues);
  }
  void deleteRow() {
    final tableValuesProvider = context.read<TableValuesProvider>();
    if (tableValues.isNotEmpty) {
      tableValues.removeLast();
      tableValuesProvider.changeTableValues(tableValues); // Update provider directly
    }
  }

  void showTotal() {
    num totalQty = 0;
    num totalAmount = 0;

    for (var item in tableValues) {
      // Use double.tryParse for safe conversion
      double? qty = double.tryParse(item['qty'] ??'0');
      double? rate = double.tryParse(item['rate'] ?? '0');
      if(qty==0 || rate==0){
        Fluttertoast.showToast(msg: 'Invalid Quantity/Rate in some items');
        FocusManager.instance.primaryFocus?.unfocus();
        return;
      }
      if (qty != null && rate != null) {
        totalAmount += qty * rate;
        totalQty += qty;
      } else {
        // Handle invalid input gracefully
        Fluttertoast.showToast(msg: 'Invalid Quantity/Rate in some items');
        FocusManager.instance.primaryFocus?.unfocus();
        return; // Exit the function early
      }
    }

    String strTotalAmt = totalAmount.toStringAsFixed(2);
    String strTotalQty = totalQty.toStringAsFixed(2);

    Alert(
      context: context,
      title: 'Calculated!',
      desc: 'Net Price: $strTotalAmt\nNet Quantity: $strTotalQty\n',
      style: const AlertStyle(
        backgroundColor: Color(0xCD000000),
        descStyle: TextStyle(color: Colors.amber),
        titleStyle: TextStyle(color: Colors.amber),
        isButtonVisible: false,
      ),
    ).show();
  }

  List<Map<String, dynamic>> tableValues = [
    {
      'image': 'assets/images/noImage.png',
      'title': '',
      'size':'na',
      'rate':'1',
      'qty':'1',
      'amount':'',
    }
  ];
  @override
  void initState() {super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<TableValuesProvider>().changeTableValues(tableValues);
  });
  }

  @override
  Widget build(BuildContext context) {
    final availProducts = Provider.of<Products>(context).availProducts;
    double screenWidth = MediaQuery.of(context).size.width;
    final border = TableBorder.all(width: 1.5);

    getColumnWidth() {
      if (screenWidth < 450) {
        double multiFactor = 565 / screenWidth;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(54.0 * multiFactor),
          2: FixedColumnWidth(84.0 * multiFactor),
          3: FixedColumnWidth(64.0 * multiFactor),
          4: FixedColumnWidth(54.0 * multiFactor),
          5: FixedColumnWidth(42.0 * multiFactor),
          6: FixedColumnWidth(64.0 * multiFactor),
        };
      } else {
        double multiFactor = screenWidth / 565;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(54.0 * multiFactor),
          2: FixedColumnWidth(84.0 * multiFactor),
          3: FixedColumnWidth(64.0 * multiFactor),
          4: FixedColumnWidth(54.0 * multiFactor),
          5: FixedColumnWidth(42.0 * multiFactor),
          6: FixedColumnWidth(64.0 * multiFactor),
        };
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<TableValuesProvider>(
          builder: (context, tableValuesProvider, child) {
            final tableValues = tableValuesProvider.tableValues;
            return Table(
              columnWidths: getColumnWidth(),
              border: border,
              children: [
                const TableRow(
                  children: [
                    CustomTableCell(text: 'Sr.'),
                    CustomTableCell(text: 'IMAGE'),
                    CustomTableCell(text: 'PRODUCT'),
                    CustomTableCell(text: 'SIZE'),
                    CustomTableCell(text: 'RATE'),
                    CustomTableCell(text: 'QTY'),
                    CustomTableCell(text: 'AMOUNT'),
                  ],
                ),
                ...List<TableRow>.generate(tableValues.length, (index) {
                  String getSrNo() {
                    int srNo = index + 1;
                    if (index < tableValues.length) {
                      tableValues[index]['sr'] = srNo;
                    } else {
                      tableValues.add({'sr': srNo});
                    }
                    return srNo.toString();
                  }

                  void showPopup(BuildContext context, int tableIndex) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ProductSearchDialog(
                            availProducts: availProducts,
                            tableIndex: tableIndex,
                          ),
                        );
                      },
                    );
                  }
                  double amount =0;
                  return TableRow(
                    children: [
                      TableCell(child: Center(child: Text(getSrNo(), style: const TextStyle(fontSize: 18),))),
                      TableCell(child: Image.asset(tableValues[index]['image'],fit: BoxFit.fill, width: 50, height: 70,)),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: SizedBox(
                            width:75,
                            height:50,
                            child: GestureDetector(
                              onTap: () => showPopup(context, index),
                              child: Text(tableValues[index]['title'], style: const TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                      TableCell(child: Center(child: Text(tableValues[index]['size'], style: const TextStyle(fontSize: 14)))),
                      TableCell(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: '0',
                          onChanged: (value){
                            if (index < tableValues.length) {
                              tableValues[index]['rate'] = value;
                              double rate = double.tryParse(value) ?? 0;
                              double qty = double.tryParse(tableValues[index]['qty']) ?? 1.0;
                              amount = qty * rate;
                              tableValues[index]['amount'] = amount.toStringAsFixed(2);
                            } else {
                              tableValues.add({'rate': value, 'amount': '0.00'}); // Add with default amount
                            }
                            context.read<TableValuesProvider>().changeTableValues(tableValues);
                          },
                        ),
                      )),
                      TableCell(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: '1',
                          onChanged: (value){
                            if (index < tableValues.length) {
                              tableValues[index]['qty'] = value;
                              // Calculate amount here
                              double qty = double.tryParse(value) ?? 1.0;
                              double rate = double.tryParse(tableValues[index]['rate']) ?? 1.0;
                              amount = qty * rate;
                              tableValues[index]['amount'] = amount.toStringAsFixed(2);
                            } else {
                              tableValues.add({'qty': value, 'amount': '0.00'}); // Add with default amount
                            }
                            context.read<TableValuesProvider>().changeTableValues(tableValues);
                          },
                        ),
                      )),
                      TableCell(child: Center(child: Text(tableValues[index]['amount'] ?? '0.00',style: const TextStyle(fontSize: 16),))),
                    ],
                  );
                }),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            DimensionButton(btnTxt: 'Add Row', fun: addRow),
            const SizedBox(width: 10),
            DimensionButton(btnTxt: 'Del Row', fun: deleteRow),
            const SizedBox(width: 10),
            DimensionButton(btnTxt: 'Total', fun: showTotal),
          ],
        ),
      ],
    );
  }
}
