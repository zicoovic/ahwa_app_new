import 'package:ahwa_app_new/screens/pending_screen.dart';
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
    final order = drinks.where((order) => !order.isCompleted).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      body: order.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No pending orders'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await customBottom(context);
                      setState(() {});
                    },
                    child: const Text('Add Drink'),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have ${drinks.length} pending orders'),
                  const SizedBox(height: 20),
                  const Icon(Icons.pending_actions, size: 50),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PendingScreen(),
                        ),
                      );
                    },
                    child: const Text('Pending orders'),
                  ),
                ],
              ),
            ),
    );
  }
}
