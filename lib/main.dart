import 'package:alif_hw_pi/Provider/product_list_provider.dart';
import 'package:alif_hw_pi/screens/main_screen.dart';
import 'package:alif_hw_pi/screens/set_rates_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/table_values_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color seedColor = const Color(0xFFF2D794);
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
              primary: const Color(0xFF212121), // Deep charcoal grey
              secondary: const Color(0xFFF2D794), // Soft amber as secondary
            ),
            useMaterial3: true,),
          home: const MainScreen(),
          routes: {
            MainScreen.id :(c)=>const MainScreen(),
            SetRatesScreen.id: (c)=> const SetRatesScreen(),
          },
        ),
    );
  }
}