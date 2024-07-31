import 'package:dyshez/model/orders.dart';
import 'package:dyshez/view/components/app_bar/app_bar.dart';
import 'package:dyshez/view/components/buttons/buttons.dart';
import 'package:dyshez/view/components/drawer_menu/drawer.dart';
import 'package:flutter/material.dart';

class OrderViewPage extends StatefulWidget {
  const OrderViewPage({super.key});

  @override
  State<OrderViewPage> createState() => _OrderViewPageState();
}

class _OrderViewPageState extends State<OrderViewPage> {
  // Ejemplo de datos de pedido
  final List<OrderItem> items = [
    OrderItem(
        name: 'Pizza italiana',
        quantity: 2,
        originalPrice: 320,
        discountedPrice: 240),
    OrderItem(
        name: 'Rebanada de pastel de chocolate',
        quantity: 3,
        originalPrice: 410,
        discountedPrice: 340),
    OrderItem(
        name: 'Refresco de 1 lt',
        quantity: 1,
        originalPrice: 62,
        discountedPrice: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(title: 'Historial'),
      drawer: DrawerMenu(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            restaurantImage(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            orderDetails(),
          ],
        ),
      )),
    );
  }

  Widget restaurantImage() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        width: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage('assets/images/restaurantImg.jpg'),
                fit: BoxFit.cover)),
      ),
    );
  }

  Widget orderDetails() {
    double totalOriginalPrice =
        items.fold(0, (sum, item) => sum + item.originalPrice);
    double totalDiscountedPrice =
        items.fold(0, (sum, item) => sum + item.discountedPrice);
    double discount = totalOriginalPrice - totalDiscountedPrice;
    double shipping = 60.00;
    double tip = 13.00;
    double totalPaid = totalDiscountedPrice + shipping + tip;

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
              'Habibi',
              style: TextStyle(
                fontFamily: 'QuickSand-Bold',
                fontSize: 24,
              ),
            ),
            Text(
              'Completado · Abr 13 a las 11:53 AM',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            Text(
              'Benito Juárez #213',
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
            Column(
              children: items.map((item) {
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
                              'x${item.quantity}',
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
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${item.originalPrice}',
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '\$${item.discountedPrice}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
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
                      'ICICI Bank Card\n**** **** **** 5486',
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
              onPress: () {},
            ),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {},
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
