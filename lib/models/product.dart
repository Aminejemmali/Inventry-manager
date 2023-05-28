class Product {
  final String id;
  final String name;
  final String designation;
  final String unite;
  final double price;
  int quantity;

  Product({required this.id,required this.name,required this.designation,required this.unite, required this.price, this.quantity = 0});

  double get totalPrice => price * quantity;
}