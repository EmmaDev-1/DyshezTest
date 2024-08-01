// Archivo: order_view_model.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/order_model.dart';

class OrderViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<OrderModel> _orders = [];
  List<OrderModel> _filteredOrders = [];
  List<OrderModel> get orders => _filteredOrders;

  Future<void> fetchOrders(String userId) async {
    print('Fetching orders for user: $userId');
    final response = await supabase
        .from('orders')
        .select('*, restaurants(restaurant_logo)')
        .eq('user_id', userId);

    final data = response as List<dynamic>;
    print('Orders data: $data');
    _orders = data.map((order) => OrderModel.fromMap(order)).toList();
    _filteredOrders = List.from(_orders); // Initially, no filters applied
    notifyListeners();

    print('Fetched orders: $_orders');
  }

  void filterOrdersByType(String orderType) {
    _filteredOrders =
        _orders.where((order) => order.orderType == orderType).toList();
    notifyListeners();
  }

  void sortOrdersByDate(bool descending) {
    _filteredOrders.sort((a, b) => descending
        ? b.ordersDatetime.compareTo(a.ordersDatetime)
        : a.ordersDatetime.compareTo(b.ordersDatetime));
    notifyListeners();
  }

  void resetFilters() {
    _filteredOrders = List.from(_orders);
    notifyListeners();
  }
}
