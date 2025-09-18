import 'package:ahwa_app_new/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderManager {
  static List<Order> _orders = <Order>[];
  static List<Order> _completedOrders = <Order>[];

  // جيب كل الأوردرات (المعلقة + المكتملة)
  static List<Order> getAllOrders() {
    return List.from(_orders);
  }

  // جيب الأوردرات المعلقة فقط
  static List<Order> getPendingOrders() {
    print('Total orders: ${_orders.length}');
    final pending = _orders.where((order) => !order.isCompleted).toList();
    print('Pending orders: ${pending.length}');
    return pending;
  }

  // جيب الأوردرات المكتملة
  static List<Order> getCompletedOrders() {
    return List.from(_completedOrders);
  }

  // حفظ البيانات في SharedPreferences
  static Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // حول الأوردرات المعلقة لـ JSON strings
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

    // حول الأوردرات المكتملة لـ JSON strings
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

    // احفظ في SharedPreferences
    await prefs.setStringList('pending_orders', ordersJson);
    await prefs.setStringList('completed_orders', completedJson);

    print('Data saved successfully');
  }

  // تحميل البيانات من SharedPreferences
  static Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // جيب الأوردرات المعلقة
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

      // جيب الأوردرات المكتملة
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

      print('Data loaded successfully');
      print('Pending orders: ${_orders.length}');
      print('Completed orders: ${_completedOrders.length}');
    } catch (e) {
      print('Error loading data: $e');
      // في حالة خطأ، ابدأ بقوائم فاضية
      _orders = <Order>[];
      _completedOrders = <Order>[];
    }
  }

  // إضافة أوردر جديد
  static Future<void> addOrder(String name, String drink, String? notes) async {
    if (name.isEmpty || drink.isEmpty) {
      print('Error: Name and drink cannot be empty');
      return;
    }

    final order = Order(name, drink, notes);
    print('Adding order: ${order.name} - ${order.drink}');
    _orders.add(order);

    await _saveData();
    print('Total orders after add: ${_orders.length}');
  }

  // إتمام أوردر (نقله من المعلقة للمكتملة)
  static Future<void> completeOrder(int index) async {
    if (index >= 0 && index < _orders.length) {
      print('Completing order at index: $index');

      // انقل الأوردر للقائمة المكتملة
      final completedOrder = _orders[index];
      completedOrder.isCompleted = true;
      _completedOrders.add(completedOrder);

      // امسح الأوردر من القائمة المعلقة
      _orders.removeAt(index);

      await _saveData();
      print('Total pending orders after completion: ${_orders.length}');
      print('Total completed orders: ${_completedOrders.length}');
    } else {
      print('Error: Invalid index $index');
    }
  }

  // إضافات للتقارير البسيطة
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

  // مسح كل البيانات (للتطوير/التجريب)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('pending_orders');
    await prefs.remove('completed_orders');

    _orders.clear();
    _completedOrders.clear();

    print('All data cleared');
  }
}
