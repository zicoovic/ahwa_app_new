import 'package:ahwa_app_new/service/order_manager.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topDrinks = OrderManager.getTopDrinks();
    final totalServed = OrderManager.getTotalOrdersServed();
    final mostPopular = OrderManager.getMostPopularDrink();

    return Scaffold(
      appBar: AppBar(title: Text('Daily Reports')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Total Orders Served: $totalServed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Most Popular Drink: $mostPopular',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Top-Selling Drinks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: topDrinks.isEmpty
                  ? Center(child: Text('No data available'))
                  : ListView.builder(
                      itemCount: topDrinks.length,
                      itemBuilder: (context, index) {
                        final entry = topDrinks.entries.elementAt(index);
                        return ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(entry.key),
                          trailing: Text('${entry.value} orders'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
