class Order {
  final String name;
  final String drink;
  String? notes;
  bool isCompleted;

  Order(this.name, this.drink, this.notes, {this.isCompleted = false});
}
