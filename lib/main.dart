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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context)=>Products()),
        ChangeNotifierProvider(create: (BuildContext context) => TableValuesProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Alif PI',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(primary: Colors.amber, seedColor: Colors.brown, background: Colors.brown[200], surface: Colors.brown[200]),
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