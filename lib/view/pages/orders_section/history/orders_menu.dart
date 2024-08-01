// Archivo: orders_menu.dart
import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/components/app_bar/app_bar.dart';
import 'package:dyshez/view/components/drawer_menu/drawer.dart';
import 'package:dyshez/view/pages/orders_section/history/order_view.dart';
import 'package:dyshez/view_model/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrdersMenuPage extends StatefulWidget {
  const OrdersMenuPage({super.key});

  @override
  _OrdersMenuPageState createState() => _OrdersMenuPageState();
}

class _OrdersMenuPageState extends State<OrdersMenuPage> {
  @override
  void initState() {
    super.initState();
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    orderViewModel.fetchOrders(orderViewModel.supabase.auth.currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(title: 'Historial'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedidos anteriores',
                style: TextStyle(
                  fontFamily: 'QuickSand-Bold',
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: orderViewModel.orders.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: orderViewModel.orders.length,
                        itemBuilder: (context, index) {
                          final order = orderViewModel.orders[index];
                          return buildOrderItem(
                            context,
                            order.restaurantName,
                            '${order.orderDetailsTotalQuantity} artículos · \$${order.orderTotalPay}',
                            order.orderType,
                            order.ordersDatetime,
                            order.restaurantLogo,
                            order.orderType,
                            order.ordersStatus,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderItem(
      BuildContext context,
      String title,
      String subtitle,
      String detail,
      DateTime dateTime,
      String imagePath,
      String orderType,
      String orderStatus) {
    String icon;
    if (orderType == 'Dyshez Direct') {
      icon = 'assets/images/dyshezDirect.png';
    } else if (orderType == 'Promo Live') {
      icon = 'assets/images/promoLive.png';
    } else {
      icon = 'assets/images/defaultIcon.png';
    }

    final formattedDate = DateFormat('MMM d, h:mm a').format(dateTime);

    Color color;

    if (orderStatus == 'Completado' || orderStatus == 'Presentado') {
      color = Colors.green;
    } else if (orderStatus == 'No presentado') {
      color = Colors.red;
    } else {
      color = Colors.grey;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imagePath),
        radius: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'QuickSand-Bold',
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'QuickSand',
                fontSize: 13),
          ),
          Text(
            detail,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'QuickSand',
                fontSize: 13),
          ),
          Text(
            '$formattedDate',
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontFamily: 'QuickSand',
                fontSize: 13),
          ),
          Text(
            '$orderStatus',
            style: TextStyle(
                color: color, fontFamily: 'QuickSand-Bold', fontSize: 14),
          )
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            scale: 25,
          ),
          SizedBox(width: 8),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 25,
          )
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () {
        Navigator.push(
          context,
          crearRuta(context, const OrderViewPage()),
        );
      },
    );
  }
}
