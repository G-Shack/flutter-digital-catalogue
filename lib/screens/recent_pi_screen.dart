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

  Future<bool> _showDeleteConfirmation(String piNo, String piName) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Delete'),
              content:
                  Text('Are you sure you want to delete PI #$piNo ($piName)?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableValuesProvider>(builder: (context, provider, child) {
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
                key: Key(currentItem['piNo'].toString()),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  // Show confirmation dialog
                  return await _showDeleteConfirmation(
                    currentItem['piNo'].toString(),
                    currentItem['piName'],
                  );
                },
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
                  // Store the PI details before removing the item
                  final deletedPiNo = currentItem['piNo'];
                  final deletedPiName = currentItem['piName'];

                  setState(() {
                    hiveService.deleteItem(deletedPiNo);
                    _items.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('PI #$deletedPiNo ($deletedPiName) deleted')),
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
                          'piNo': currentItem['piNo'], // Pass piNo
                        },
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(
                        currentItem['piNo'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      'PI #${currentItem['piNo']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentItem['piName']),
                        Text(
                          formatDate(currentItem['date']),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            }),
      );
    });
  }
}
