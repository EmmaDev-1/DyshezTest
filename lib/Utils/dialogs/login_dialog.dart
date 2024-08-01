import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/pages/orders_section/orders_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dyshez/utils/dialogs/error_dialog.dart';
import 'package:dyshez/utils/dialogs/show_loading.dart';
import 'package:dyshez/utils/dialogs/show_snackbar.dart';
import 'package:dyshez/view_model/auth_view_model.dart';
import 'package:dyshez/view_model/login_view_model.dart';

Future<void> loginUser(BuildContext context) async {
  final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

  final validationError = loginViewModel.validateFields();
  if (validationError != null) {
    showSnackBar(context, validationError);
    return;
  }

  try {
    showLoadingDialog(context);

    String username = loginViewModel.controllers['Username']!.text;
    String password = loginViewModel.controllers['Password']!.text;

    await authViewModel.signIn(
      username,
      password,
    );

    Navigator.pop(context); // Cerrar el diálogo de carga

    // Navegar a la página de ordenes
    Navigator.push(
      context,
      crearRuta(const OrdersMenuPage()),
    );
  } catch (e) {
    Navigator.pop(context); // Cerrar el diálogo de carga
    String errorMessage = e.toString();
    if (errorMessage.contains('Usuario no encontrado')) {
      showSnackBar(context, 'Credenciales incorrectas.');
    } else if (errorMessage.contains('Contraseña incorrecta')) {
      showSnackBar(context, 'Contraseña incorrecta.');
    } else {
      ErrorDialog.show(context, e.toString());
    }
  }
}

Future<void> loginWithGoogle(BuildContext context) async {
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

  try {
    await authViewModel.googleSignIn();
    Navigator.push(
      context,
      crearRuta(const OrdersMenuPage()),
    );
  } catch (e) {
    showSnackBar(context, 'Algo salio mal, intentalo más tarde');
  }
}
