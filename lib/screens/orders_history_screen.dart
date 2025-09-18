import 'package:ahwa_app_new/service/order_manager.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completedOrders = OrderManager.getCompletedOrders();

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: completedOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 50, color: Colors.grey),
                  SizedBox(height: 20),
                  Text('No completed orders yet'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: completedOrders.length,
              itemBuilder: (context, index) {
                final order = completedOrders[index];
                return ListTile(
                  title: Text('${order.name} - ${order.drink}'),
                  subtitle: order.notes?.isNotEmpty == true
                      ? Text('Notes: ${order.notes}')
                      : null,
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
    );
  }
}
