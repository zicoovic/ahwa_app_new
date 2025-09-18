import 'package:ahwa_app_new/screens/orders_history_screen.dart';
import 'package:ahwa_app_new/screens/pending_screen.dart';
import 'package:ahwa_app_new/screens/report_screen.dart';
import 'package:ahwa_app_new/service/order_manager.dart';
import 'package:ahwa_app_new/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final order = OrderManager.getPendingOrders();

    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      body: order.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No pending orders'),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await customBottom(context);
                          setState(() {});
                        },
                        child: const Text('Add Drink'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OrderHistoryScreen(),
                            ),
                          );
                        },
                        child: const Text('Orders History'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReportsScreen(),
                            ),
                          );
                        },
                        child: const Text('View Reports'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have ${order.length} pending orders'),
                  const SizedBox(height: 20),
                  const Icon(Icons.pending_actions, size: 50),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PendingScreen(),
                        ),
                      );

                      if (result == 'refresh') {
                        setState(() {});
                      }
                    },
                    child: const Text('Pending orders'),
                  ),
                ],
              ),
            ),
    );
  }
}
