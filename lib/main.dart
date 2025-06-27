import 'package:alif_hw_pi/Provider/product_list_provider.dart';
import 'package:alif_hw_pi/screens/dimension_page.dart';
import 'package:alif_hw_pi/screens/main_screen.dart';
import 'package:alif_hw_pi/screens/recent_pi_screen.dart';
import 'package:alif_hw_pi/screens/set_rates_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Provider/table_values_provider.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('recent_pi_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color seedColor = const Color(0xFFF2D794);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Products()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TableValuesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'A.S. Hardware PI',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            primary: const Color(0xFF212121),
            secondary: const Color(0xFFF2D794),
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        navigatorObservers: [routeObserver],
        routes: {
          '/': (context) => const MainScreen(),
          '/dimensions': (context) => DimensionPage(
                billName: (ModalRoute.of(context)!.settings.arguments
                    as Map<String, dynamic>)['billName'] as String,
              ),
          '/setRates': (context) => const SetRatesScreen(),
          '/recentPi': (context) => const RecentPiScreen(),
        },
      ),
    );
  }
}
