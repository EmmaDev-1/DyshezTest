// Archivo: order_view.dart
import 'package:dyshez/Utils/select_order/color_select.dart';
import 'package:dyshez/model/order_item_model.dart';
import 'package:dyshez/model/order_model.dart'; // Asegúrate de importar el modelo de Order
import 'package:dyshez/view/components/app_bar/app_bar.dart';
import 'package:dyshez/view/components/buttons/buttons.dart';
import 'package:dyshez/view/components/drawer_menu/drawer.dart';
import 'package:dyshez/view_model/order_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderViewPage extends StatefulWidget {
  final OrderModel order;
  const OrderViewPage({super.key, required this.order});

  @override
  State<OrderViewPage> createState() => _OrderViewPageState();
}

class _OrderViewPageState extends State<OrderViewPage> {
  @override
  void initState() {
    super.initState();
    final orderDetailViewModel =
        Provider.of<OrderDetailViewModel>(context, listen: false);
    orderDetailViewModel.fetchOrderDetails(widget.order.ordersId);
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailViewModel = Provider.of<OrderDetailViewModel>(context);
    final orderDetails = orderDetailViewModel.orderDetails;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'Historial',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              restaurantImage(widget.order.restaurantLogo),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              orderDetailsWidget(orderDetails),
            ],
          ),
        ),
      ),
    );
  }

  Widget restaurantImage(String imageUrl) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        width: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover)),
      ),
    );
  }

  Widget orderDetailsWidget(List<OrderDetailModel> details) {
    double totalOriginalPrice = details.fold(
        0, (sum, item) => sum + (item.itemPrice) * (item.orderDetailQuantity));
    double totalDiscountedPrice =
        totalOriginalPrice; // Ajusta esto según sea necesario
    double discount = 0; // Ajusta esto según sea necesario
    double shipping = widget.order.orderDeliveryPay;
    double tip = widget.order.orderTipPay;
    double totalPaid = totalDiscountedPrice + shipping + tip - discount;
    String payMethod = widget.order.orderPayMethod;

    Color colorOrder = selectOrderStatus(widget.order.ordersStatus);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.order.restaurantName,
              style: TextStyle(
                fontFamily: 'QuickSand-Bold',
                fontSize: 24,
              ),
            ),
            Text(
              '${widget.order.ordersStatus} · ${DateFormat('MMM d h:mm a').format(widget.order.ordersDatetime)}',
              style: TextStyle(
                color: colorOrder,
              ),
            ),
            Text(
              widget.order.restaurantLocation,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tu pedido',
              style: TextStyle(
                fontFamily: 'QuickSand-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: details.length,
              itemBuilder: (context, index) {
                final item = details[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.pink[100],
                            child: Text(
                              'x${item.orderDetailQuantity}',
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              item.itemName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${(item.itemPrice).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total de los artículos'),
                Text('\$${totalOriginalPrice.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Descuentos', style: TextStyle(color: Colors.green)),
                Text('-\$${discount.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.green)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Envío'),
                Text('\$${shipping.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Propina'),
                Text('\$${tip.toStringAsFixed(2)}'),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total pagado',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${totalPaid.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Método de pago'),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/visaLogo.png', // Ruta a tu imagen de la tarjeta
                      width: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$payMethod\n**** **** **** 5486',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ButtonsComponents(
              color: const Color(0xFFE3026F),
              title: 'Reordenar',
              onPress: () {
                Fluttertoast.showToast(
                  msg: "Función habilitada próximamente",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              },
            ),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Función habilitada próximamente",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              },
              style: OutlinedButton.styleFrom(
                side:
                    BorderSide(color: const Color.fromARGB(255, 204, 204, 204)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Center(
                child: Text(
                  'Ver factura',
                  style: TextStyle(
                    fontFamily: 'QuickSand-Bold',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
