class OrderModel {
  final int ordersId;
  final String userId;
  final int restaurantId;
  final String restaurantName;
  final int orderDetailsTotalQuantity;
  final String orderType;
  final DateTime ordersDatetime;
  final String restaurantLocation;
  final String ordersStatus;
  final double orderTotalPay;
  final double orderDiscount;
  final double orderDeliveryPay;
  final double orderTipPay;
  final String orderPayMethod;
  final String restaurantLogo;

  OrderModel({
    required this.ordersId,
    required this.userId,
    required this.restaurantId,
    required this.restaurantName,
    required this.orderDetailsTotalQuantity,
    required this.orderType,
    required this.ordersDatetime,
    required this.restaurantLocation,
    required this.ordersStatus,
    required this.orderTotalPay,
    required this.orderDiscount,
    required this.orderDeliveryPay,
    required this.orderTipPay,
    required this.orderPayMethod,
    required this.restaurantLogo,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      ordersId: map['orders_id'],
      userId: map['user_id'],
      restaurantId: map['restaurant_id'],
      restaurantName: map['restaurant_name'],
      orderDetailsTotalQuantity: map['order_details_total_quantity'],
      orderType: map['order_type'],
      ordersDatetime: DateTime.parse(map['orders_datetime']),
      restaurantLocation: map['restaurant_location'],
      ordersStatus: map['orders_status'],
      orderTotalPay: map['order_total_pay'],
      orderDiscount: map['order_discount'],
      orderDeliveryPay: map['order_delivery_pay'],
      orderTipPay: map['order_tip_pay'],
      orderPayMethod: map['order_pay_method'],
      restaurantLogo: map['restaurants']['restaurant_logo'],
    );
  }
}
