// Archivo: orders_menu.dart
import 'package:dyshez/Utils/dialogs/sign_out_dialog.dart';
import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/components/app_bar/app_bar.dart';
import 'package:dyshez/view/components/drawer_menu/drawer.dart';
import 'package:dyshez/Utils/select_order/color_select.dart';
import 'package:dyshez/Utils/select_order/image_select.dart';
import 'package:dyshez/view/components/orders_filter/filter.dart';
import 'package:dyshez/view/pages/orders_section/order_view.dart';
import 'package:dyshez/view_model/order_details_view_model.dart';
import 'package:dyshez/view_model/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:dyshez/model/order_model.dart';

class OrdersMenuPage extends StatefulWidget {
  const OrdersMenuPage({super.key});

  @override
  _OrdersMenuPageState createState() => _OrdersMenuPageState();
}

class _OrdersMenuPageState extends State<OrdersMenuPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    orderViewModel
        .fetchOrders(orderViewModel.supabase.auth.currentUser!.id)
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'Historial',
        onTap: () {
          SignOutUser(context);
        },
      ),
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedidos anteriores',
                    style: TextStyle(
                      fontFamily: 'QuickSand-Bold',
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const OrderFilterMenu(),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : orderViewModel.orders.isEmpty
                          ? Center(
                              child: Text(
                                'No hay órdenes',
                                style: TextStyle(
                                  fontFamily: 'QuickSand-Bold',
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: orderViewModel.orders.length,
                              itemBuilder: (context, index) {
                                final order = orderViewModel.orders[index];
                                return buildOrderItem(
                                  context,
                                  order,
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderItem(BuildContext context, OrderModel order) {
    String icon = selectImageOrder(order.orderType);
    Color colorOrder = selectOrderStatus(order.ordersStatus);

    final formattedDate =
        DateFormat('MMM d, h:mm a').format(order.ordersDatetime);

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/logo.png',
            image: order.restaurantLogo,
            fit: BoxFit.cover,
            width: 48,
            height: 48,
          ),
        ),
      ),
      title: Text(
        order.restaurantName,
        style: const TextStyle(
          fontFamily: 'QuickSand-Bold',
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${order.orderDetailsTotalQuantity} artículos · \$${order.orderTotalPay}',
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'QuickSand',
                fontSize: 13),
          ),
          Text(
            order.orderType,
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
            order.ordersStatus,
            style: TextStyle(
                color: colorOrder, fontFamily: 'QuickSand-Bold', fontSize: 14),
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
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 25,
          )
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () {
        Navigator.push(
          context,
          crearRuta(
            ChangeNotifierProvider(
              create: (_) => OrderDetailViewModel(),
              child: OrderViewPage(order: order),
            ),
          ),
        );
      },
    );
  }
}
