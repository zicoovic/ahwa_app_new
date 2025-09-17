import 'package:ahwa_app_new/screens/order_screen.dart';
import 'package:ahwa_app_new/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});
  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    final pending = drinks.where((order) => !order.isCompleted).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Orders')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
      body: pending.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No pending orders'),
                  SizedBox(height: 20),
                  Icon(Icons.pending_actions, size: 50),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const OrderScreen()),
                      );
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text('Add Order'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(drinks[index].name),
                      Text(drinks[index].drink),
                      drinks[index].notes!.isNotEmpty
                          ? Text("(${drinks[index].notes})")
                          : SizedBox.shrink(),
                    ],
                  ),
                  subtitle: Text(
                    "Pending",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        drinks[index].isCompleted = true;
                        Navigator.pop(context);
                        drinks.removeWhere((order) => order.isCompleted);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Drink marked as completed!')),
                        );
                      });
                    },
                    icon: Icon(Icons.check_box, color: Colors.green),
                  ),
                );
              },
            ),
    );
  }
}
