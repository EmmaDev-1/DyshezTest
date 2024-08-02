import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final Map<String, TextEditingController> controllers = {
    'Username': TextEditingController(),
    'Password': TextEditingController(),
  };

  String? validateFields() {
    for (var entry in controllers.entries) {
      if (entry.value.text.isEmpty) {
        return 'El campo "${entry.key}" no puede estar vacío';
      }
    }
    return null;
  }

  void disposeControllers() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
  }
}
