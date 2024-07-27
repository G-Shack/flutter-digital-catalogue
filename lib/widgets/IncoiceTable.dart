import 'package:alif_hw_pi/widgets/CustomTableCell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../Provider/ProductListProvider.dart';
import '../Provider/TableValuesProvider.dart';
import 'DimensionButton.dart';
import 'ProductSearchDialog.dart';


class InvoiceTable extends StatefulWidget {
  InvoiceTable({super.key});

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
      'rate': '',
      'qty': '1',
      'amount': '',
    });
    tableValuesProvider.changeTableValues(tableValues); // Update providerdirectly
  }
  void deleteRow() {
    final tableValuesProvider = context.read<TableValuesProvider>();
    if (tableValues.isNotEmpty) {
      tableValues.removeLast();
      tableValuesProvider.changeTableValues(tableValues); // Update provider directly
    }
  }

  List<Map<String, dynamic>> tableValues = [
    {
      'image': 'assets/images/noImage.png',
      'title': '',
      'size':'na',
      'rate':'',
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
    final _border = TableBorder.all(width: 1.5);

    getColumnWidth() {
      if (screenWidth < 450) {
        double multiFactor = 565 / screenWidth;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),1: FixedColumnWidth(54.0 * multiFactor),
          2: FixedColumnWidth(64.0 * multiFactor),
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
          2: FixedColumnWidth(64.0 * multiFactor),
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
              border: _border,
              children: [
                TableRow(
                  children: [
                    CustomTableCell(text: 'Sr.'),
                    CustomTableCell(text: 'Image'),
                    CustomTableCell(text: 'Product'),
                    CustomTableCell(text: 'Size'),
                    CustomTableCell(text: 'Rate'),
                    CustomTableCell(text: 'Qty'),
                    CustomTableCell(text: 'Amount'),
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

                  void _showPopup(BuildContext context, int tableIndex) {
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

                  return TableRow(
                    children: [
                      TableCell(child: Text(getSrNo())),
                      TableCell(child: Image.asset(tableValues[index]['image'])),
                      TableCell(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: GestureDetector(
                            onTap: () => _showPopup(context, index),
                            child: Text(tableValues[index]['title']),
                          ),
                        ),
                      ),
                      TableCell(child: Text(tableValues[index]['size'])),
                      TableCell(child: Text(tableValues[index]['rate'])),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('1')),
                    ],
                  );
                }),
              ],
            );
          },
        ),
        SizedBox(height: 20),
        Row(
          children: [
            DimensionButton(btnTxt: 'Add Row', fun: addRow),
            const SizedBox(width: 10),
            DimensionButton(btnTxt: 'Del Row', fun: deleteRow),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
