import 'package:alif_hw_pi/Provider/table_values_provider.dart';
import 'package:alif_hw_pi/Services/hive_service.dart';
import 'package:alif_hw_pi/main.dart';
import 'package:alif_hw_pi/widgets/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecentPiScreen extends StatefulWidget {
  static const id = '/RecentPiScreen';
  const RecentPiScreen({super.key});

  @override
  State<RecentPiScreen> createState() => _RecentPiScreenState();
}

class _RecentPiScreenState extends State<RecentPiScreen> with RouteAware {
  List<Map<String, dynamic>> _items = [];
  HiveService hiveService = HiveService();

  @override
  void didPopNext() {
    setState(() {
      _items = hiveService.refreshItems();
    });
    super.didPopNext();
  }

  @override
  void initState() {
    setState(() {
      _items = hiveService.refreshItems();
      // print(_items);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableValuesProvider>(builder: (context, provider, child) {
      // provider.tableValues.clear();
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: MediaQuery.of(context).size.width < 600,
          title: const Text('Recents'),
        ),
        drawer:
            MediaQuery.of(context).size.width < 600 ? const AppDrawer() : null,
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final currentItem = _items[index];

              String formatDate(DateTime date) {
                return DateFormat('dd/MM/yy').format(date);
              }

              return Dismissible(
                key: Key(_items[index]['piNo'].toString()),
                direction: DismissDirection.endToStart,
                background: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    hiveService.deleteItem(_items[index]['piNo']);
                    _items.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('PI ${_items[index]['piName']} deleted')),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    onTap: () {
                      List<Map<String, dynamic>> currentTableValues =
                          (currentItem['tableValues'] as List)
                              .map((item) =>
                                  Map<String, dynamic>.from(item as Map))
                              .toList();
                      context
                          .read<TableValuesProvider>()
                          .changeTableValues(currentTableValues);
                      Navigator.pushNamed(
                        context,
                        '/dimensions',
                        arguments: {
                          'billName': currentItem['piName'],
                        },
                      );
                    },
                    leading: Text(
                      currentItem['piNo'].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    leadingAndTrailingTextStyle: const TextStyle(fontSize: 16),
                    title: Text(currentItem['piName']),
                    subtitle: Text(formatDate(currentItem['date'])),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            }),
      );
    });
  }
}
