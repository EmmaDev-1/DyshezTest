import 'dart:ui';

import 'package:flutter/material.dart';

Color selectOrderStatus(String orderStatus) {
  Color color;

  if (orderStatus == 'Completado' || orderStatus == 'Presentado') {
    color = Colors.green;
    return color;
  } else if (orderStatus == 'No presentado') {
    color = Colors.red;
    return color;
  } else {
    color = Colors.grey;
    return color;
  }
}
