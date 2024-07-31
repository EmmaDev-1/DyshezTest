import 'package:dyshez/Utils/dialogs/show_loading.dart';
import 'package:dyshez/Utils/dialogs/show_snackbar.dart';
import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/pages/orders_section/history/orders_menu.dart';
import 'package:dyshez/view_model/auth_view_model.dart';
import 'package:dyshez/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Future<void> verifyAcount(
    BuildContext context, String token, String email) async {
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
  final registerViewModel =
      Provider.of<RegisterViewModel>(context, listen: false);

  showLoadingDialog(context);
  try {
    String username = registerViewModel.controllers['Username']!.text;
    await authViewModel.verifyToken(email, token);

    Navigator.pop(context); // Cerrar el diálogo de carga

    // Navegar a la página de ordenes
    Navigator.push(
      context,
      crearRuta(context, const OrdersMenuPage()),
    );

    showWelcomeDialog(context, username);
  } catch (e) {
    Navigator.pop(context); // Cerrar el diálogo de carga
    showSnackBar(context, 'Token inválido o expirado');
  }
}

Future<void> showWelcomeDialog(BuildContext context, String username) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Welcome $username!',
          textAlign: TextAlign.center,
        ),
        content: Lottie.asset(
          'assets/animations/success.json',
          repeat: false,
          frameRate: FrameRate.max,
        ),
      );
    },
  );
}
