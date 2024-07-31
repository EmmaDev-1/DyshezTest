import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/components/app_bar/app_bar.dart';
import 'package:dyshez/view/components/drawer_menu/drawer.dart';
import 'package:dyshez/view/pages/orders_section/history/order_view.dart';
import 'package:flutter/material.dart';

class OrdersMenuPage extends StatelessWidget {
  const OrdersMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView(
                    children: [
                      buildOrderItem(
                          context,
                          'Habibi',
                          '3 artículos · \$480.00',
                          'Dyshez Direct',
                          'Abr 13 · Completado',
                          'assets/images/habibi.png',
                          'assets/images/arrowsTransaction.png'),
                      buildOrderItem(
                          context,
                          'Boston’s Pizza',
                          '3 artículos · \$500.00',
                          'Promo Live',
                          'Abr 13 · No presentado',
                          'assets/images/boston.png',
                          'assets/images/arrowsTransaction.png'),
                      buildOrderItem(
                          context,
                          'Dirty Grill',
                          '\$0.00',
                          'Promo Live',
                          'Abr 13 · Presentado',
                          'assets/images/dirty.png',
                          'assets/images/arrowsTransaction.png'),
                      buildOrderItem(
                          context,
                          'Tabom',
                          '2 artículos · \$199.00',
                          'Dyshez Direct',
                          'Abr 13 · Completado',
                          'assets/images/tabom.png',
                          'assets/images/arrowsTransaction.png'),
                      buildOrderItem(
                          context,
                          'Roca',
                          '1 artículo · \$40.00',
                          'Dyshez Direct',
                          'Abr 13 · Completado',
                          'assets/images/roca.png',
                          'assets/images/arrowsTransaction.png'),
                      buildOrderItem(
                          context,
                          'Habibi',
                          '3 artículos · \$480.00',
                          'Dyshez Direct',
                          'Abr 13 · Completado',
                          'assets/images/habibi.png',
                          'assets/images/arrowsTransaction.png'),
                      // Añade más elementos según sea necesario
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderItem(BuildContext context, String title, String subtitle,
      String detail, String date, String imagePath, String icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
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
          Text(subtitle),
          Text(detail),
          Text(date, style: TextStyle(color: Colors.grey)),
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
