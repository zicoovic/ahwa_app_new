import 'package:ahwa_app_new/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderManager {
  static List<Order> _orders = <Order>[];
  static List<Order> _completedOrders = <Order>[];

  static List<Order> getAllOrders() {
    return List.from(_orders);
  }

  static List<Order> getPendingOrders() {
    final pending = _orders.where((order) => !order.isCompleted).toList();
    return pending;
  }

  static List<Order> getCompletedOrders() {
    return List.from(_completedOrders);
  }

  static Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> ordersJson = _orders
        .map(
          (order) => jsonEncode({
            'name': order.name,
            'drink': order.drink,
            'notes': order.notes,
            'isCompleted': order.isCompleted,
          }),
        )
        .toList();

    List<String> completedJson = _completedOrders
        .map(
          (order) => jsonEncode({
            'name': order.name,
            'drink': order.drink,
            'notes': order.notes,
            'isCompleted': true,
          }),
        )
        .toList();

    await prefs.setStringList('pending_orders', ordersJson);
    await prefs.setStringList('completed_orders', completedJson);
  }

  static Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      List<String>? ordersJson = prefs.getStringList('pending_orders');
      if (ordersJson != null) {
        _orders = ordersJson.map((orderStr) {
          Map<String, dynamic> orderMap = jsonDecode(orderStr);
          return Order(
            orderMap['name'] ?? '',
            orderMap['drink'] ?? '',
            orderMap['notes'],
            isCompleted: orderMap['isCompleted'] ?? false,
          );
        }).toList();
      }

      List<String>? completedJson = prefs.getStringList('completed_orders');
      if (completedJson != null) {
        _completedOrders = completedJson.map((orderStr) {
          Map<String, dynamic> orderMap = jsonDecode(orderStr);
          return Order(
            orderMap['name'] ?? '',
            orderMap['drink'] ?? '',
            orderMap['notes'],
            isCompleted: true,
          );
        }).toList();
      }
    } catch (e) {
      _orders = <Order>[];
      _completedOrders = <Order>[];
    }
  }

  static Future<void> addOrder(String name, String drink, String? notes) async {
    if (name.isEmpty || drink.isEmpty) {
      return;
    }

    final order = Order(name, drink, notes);
    _orders.add(order);

    await _saveData();
  }

  static Future<void> completeOrder(int index) async {
    if (index >= 0 && index < _orders.length) {
      final completedOrder = _orders[index];
      completedOrder.isCompleted = true;
      _completedOrders.add(completedOrder);

      _orders.removeAt(index);

      await _saveData();
    } else {}
  }

  static Map<String, int> getTopDrinks() {
    final allOrders = [..._orders, ..._completedOrders];
    final drinkCount = <String, int>{};

    for (final order in allOrders) {
      drinkCount[order.drink] = (drinkCount[order.drink] ?? 0) + 1;
    }

    return drinkCount;
  }

  static int getTotalOrdersServed() {
    return _completedOrders.length;
  }

  static String getMostPopularDrink() {
    final drinks = getTopDrinks();
    if (drinks.isEmpty) return 'No orders yet';

    String mostPopular = '';
    int maxCount = 0;

    drinks.forEach((drink, count) {
      if (count > maxCount) {
        maxCount = count;
        mostPopular = drink;
      }
    });

    return mostPopular.isEmpty ? 'No orders yet' : mostPopular;
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('pending_orders');
    await prefs.remove('completed_orders');

    _orders.clear();
    _completedOrders.clear();
  }
}
