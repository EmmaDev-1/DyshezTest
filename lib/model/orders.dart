class OrderItem {
  final String name;
  final int quantity;
  final double originalPrice;
  final double discountedPrice;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.originalPrice,
    required this.discountedPrice,
  });
}
