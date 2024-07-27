import 'package:alif_hw_pi/Provider/ProductListProvider.dart';
import 'package:alif_hw_pi/screens/MainScreen.dart';
import 'package:alif_hw_pi/screens/SetRatesScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/TableValuesProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color seedColor = Color(0xFFF2D794);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context)=>Products()),
        ChangeNotifierProvider(create: (BuildContext context) => TableValuesProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'A.S. Hardware PI',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              primary: Color(0xFF212121), // Deep charcoal grey
              secondary: Color(0xFFF2D794), // Soft amber as secondary
            ),
            useMaterial3: true,),
          home: MainScreen(),
          routes: {
            MainScreen.id :(c)=>MainScreen(),
            SetRatesScreen.id: (c)=> SetRatesScreen(),
            //ProductDetailsScreen.id :(c)=>ProductDetailsScreen(),
            //OrderScreen.id :(c)=>OrderScreen(),
          },
        ),
    );
  }
}