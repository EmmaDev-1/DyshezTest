import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  final Map<String, TextEditingController> controllers = {
    'Username': TextEditingController(),
    'Nombre': TextEditingController(),
    'Email': TextEditingController(),
    'Teléfono': TextEditingController(),
    'Contraseña': TextEditingController(),
    'Verificar contraseña': TextEditingController(),
  };

  String? validateFields() {
    for (var entry in controllers.entries) {
      if (entry.value.text.isEmpty) {
        return 'El campo "${entry.key}" no puede estar vacío';
      }
    }
    if (controllers['Contraseña']!.text !=
        controllers['Verificar contraseña']!.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  void disposeControllers() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
  }
}
