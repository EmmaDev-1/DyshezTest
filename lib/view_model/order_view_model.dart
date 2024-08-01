import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/order_model.dart';

class OrderViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  Future<void> fetchOrders(String userId) async {
    print('Aqui si entro');
    final response = await supabase
        .from('orders')
        .select('*, restaurants(restaurant_logo)')
        .eq('user_id', userId)
        .order('orders_datetime', ascending: false);
    print('Esta es el response: $response');

    final data = response as List<dynamic>;
    print('Esta es la data: $data');
    _orders = data.map((order) => OrderModel.fromMap(order)).toList();
    notifyListeners();

    print('Estas son las ordenes: $_orders');
  }
}
