// Archivo: order_detail_model.dart
class OrderDetailModel {
  final int orderDetailId;
  final int orderId;
  final int itemId;
  final String itemName;
  final double itemPrice;
  final int orderDetailQuantity;

  OrderDetailModel({
    required this.orderDetailId,
    required this.orderId,
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.orderDetailQuantity,
  });

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      orderDetailId: map['order_details_id'],
      orderId: map['orders_id'],
      itemId: map['item_id'],
      itemName: map['item_name'],
      itemPrice: map['item_price'],
      orderDetailQuantity: map['order_details_quantity'],
    );
  }
}
