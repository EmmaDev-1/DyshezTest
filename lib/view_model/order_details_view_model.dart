// Archivo: order_detail_view_model.dart
import 'package:dyshez/model/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderDetailViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<OrderDetailModel> _orderDetails = [];
  List<OrderDetailModel> get orderDetails => _orderDetails;

  Future<void> fetchOrderDetails(int orderId) async {
    print('Fetching order details for order: $orderId');
    final response = await supabase
        .from('order_details')
        .select('*')
        .eq('orders_id', orderId);

    final data = response as List<dynamic>;
    print('Order details data: $data');
    _orderDetails =
        data.map((detail) => OrderDetailModel.fromMap(detail)).toList();
    notifyListeners();

    print('Fetched order details: $_orderDetails');
  }
}
