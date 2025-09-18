import 'package:ahwa_app_new/service/order_manager.dart';
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
    final pending = OrderManager.getPendingOrders();

    return Scaffold(
      appBar: AppBar(title: const Text('Pending Orders')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await customBottom(context);
          setState(() {});
        },
        child: Center(child: Text("Add more orders")),
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
                      Navigator.pop(context);
                    },
                    child: Text('Add Order'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: pending.length,
              itemBuilder: (context, index) {
                final order = pending[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.name),
                      Text(order.drink),
                      if (order.notes?.isNotEmpty == true)
                        Text("(${order.notes})"),
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
                      final allOrders = OrderManager.getAllOrders();
                      final actualIndex = allOrders.indexWhere(
                        (o) => o.name == order.name && o.drink == order.drink,
                      );
                      OrderManager.completeOrder(actualIndex);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Drink marked as completed!')),
                      );
                      setState(() {});

                      Navigator.pop(context, 'refresh'); //// حدث الشاشة الحالية
                    },
                    icon: Icon(Icons.check_box, color: Colors.green),
                  ),
                );
              },
            ),
    );
  }
}
