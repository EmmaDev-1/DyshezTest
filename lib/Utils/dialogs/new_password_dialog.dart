import 'package:dyshez/Utils/dialogs/show_loading.dart';
import 'package:dyshez/Utils/dialogs/show_snackbar.dart';
import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/pages/authentication_section/login/login.dart';
import 'package:dyshez/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> setNewPassword(BuildContext context, String password) async {
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

  try {
    showLoadingDialog(context);
    await authViewModel.resetPassword(password);
    Navigator.pop(context); // Cerrar el diálogo de carga
    showSnackBar(context, 'Contraseña cambiada');
    Navigator.push(
      context,
      crearRuta(context, const LoginPage()),
    );
  } catch (e) {
    Navigator.pop(context); // Cerrar el diálogo de carga
    String errorMessage = e.toString();
    if (errorMessage.contains('No puedes usar la misma contraseña que antes')) {
      showSnackBar(context, 'No puedes usar la misma contraseña que antes');
    } else if (errorMessage.contains('Contraseña inválida')) {
      showSnackBar(context, 'Contraseña incorrecta.');
    } else {
      showSnackBar(context, 'Algo salio mal, intentalo nuevamente');
    }
  }
}
