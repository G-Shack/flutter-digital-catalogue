import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  final String text;
  const CustomTableCell({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
      )),
    );
  }
}
