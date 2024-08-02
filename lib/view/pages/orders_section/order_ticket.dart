// Archivo: order_ticket.dart
import 'package:dyshez/model/order_model.dart';
import 'package:dyshez/model/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class OrderTicketPage extends StatelessWidget {
  final OrderModel order;
  final List<OrderDetailModel> orderDetails;
  final ScreenshotController screenshotController = ScreenshotController();

  OrderTicketPage({
    super.key,
    required this.order,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Factura'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/images/arrowback.png',
            scale: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () async {
              // Capturar la pantalla y compartir
              final directory = (await getApplicationDocumentsDirectory()).path;
              final imagePath = await screenshotController
                  .captureAndSave(directory, fileName: 'order_ticket.png');
              if (imagePath != null) {
                Share.shareFiles([imagePath]);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ticket(),
        ),
      ),
    );
  }

  Widget ticket() {
    int totalItems = orderDetails.fold(
      0,
      (sum, item) => sum + item.orderDetailQuantity,
    );

    return Column(
      children: [
        Text('¡Gracias por tu compra!'),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tu orden de ${order.restaurantName}'),
                  Text('Enviado por ${order.orderType}'),
                  SizedBox(height: 10),
                  Text(
                      'Fecha de la orden: ${DateFormat('MMM d, h:mm a').format(order.ordersDatetime)}'),
                  SizedBox(height: 20),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderDetails.length,
                    itemBuilder: (context, index) {
                      final item = orderDetails[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'x${item.orderDetailQuantity}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    item.itemName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '\$${(item.itemPrice).toStringAsFixed(2)} -',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '\$${(item.itemPrice * item.orderDetailQuantity).toStringAsFixed(2)}',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Text('Productos totales: $totalItems'),
                  SizedBox(height: 10),
                  Text(
                      'Precio total: \$${order.orderTotalPay.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
