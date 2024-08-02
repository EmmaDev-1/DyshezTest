// Archivo: order_filter_menu.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dyshez/view_model/order_view_model.dart';

class OrderFilterMenu extends StatelessWidget {
  const OrderFilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'Dyshez Direct':
          case 'Promo Live':
            orderViewModel.filterOrdersByType(value);
            break;
          case 'Date Ascending':
            orderViewModel.sortOrdersByDate(false);
            break;
          case 'Date Descending':
            orderViewModel.sortOrdersByDate(true);
            break;
          case 'Reset':
            orderViewModel.resetFilters();
            break;
        }
      },
      icon: Icon(Icons.filter_list),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Dyshez Direct',
            child: Text('Dyshez Direct'),
          ),
          PopupMenuItem<String>(
            value: 'Promo Live',
            child: Text('Promo Live'),
          ),
          PopupMenuItem<String>(
            value: 'Date Ascending',
            child: Text('Fecha: Más antiguo primero'),
          ),
          PopupMenuItem<String>(
            value: 'Date Descending',
            child: Text('Fecha: Más reciente primero'),
          ),
          PopupMenuItem<String>(
            value: 'Reset',
            child: Text('Resetear filtros'),
          ),
        ];
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
