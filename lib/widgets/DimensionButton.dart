import 'package:flutter/material.dart';

class DimensionButton extends StatelessWidget {
  final String btnTxt;
  final void Function()? fun;
  const DimensionButton({super.key, required this.btnTxt, required this.fun});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.amberAccent),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))))),
        onPressed: () {
          fun!();
        },
        child: Text(btnTxt));
  }
}
