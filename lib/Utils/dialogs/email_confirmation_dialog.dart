import 'package:dyshez/Utils/dialogs/show_loading.dart';
import 'package:dyshez/Utils/dialogs/show_snackbar.dart';
import 'package:dyshez/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> confirmEmailForResetPassword(
    BuildContext context, String email) async {
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

  try {
    showLoadingDialog(context);
    await authViewModel.sendEmailforPasswordChange(email);
    Navigator.pop(context); // Cerrar el diálogo de carga
    showSnackBar(context, 'Correo enviado');
  } catch (e) {
    Navigator.pop(context); // Cerrar el diálogo de carga
    showSnackBar(context, 'Algo salio mal, intentalo nuevamente');
  }
}
