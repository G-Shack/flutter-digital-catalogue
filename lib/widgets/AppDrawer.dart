import 'package:alif_hw_pi/screens/main_screen.dart';
import 'package:alif_hw_pi/screens/set_rates_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xCD000000),
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.note_alt_sharp,
              color: Colors.amber,
              size: 38,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.amber,),
            title: const Text('HOME', style: TextStyle(letterSpacing: 14, fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            onTap: () {
              Navigator.of(context).popAndPushNamed(MainScreen.id);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.amber,),
            title: const Text('SET RATES', style: TextStyle(letterSpacing: 12, fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            onTap: () {
              Navigator.of(context).popAndPushNamed(SetRatesScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
