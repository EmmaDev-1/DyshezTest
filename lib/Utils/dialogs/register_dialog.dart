import 'package:dyshez/view/pages/authentication_section/verify/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dyshez/utils/dialogs/error_dialog.dart';
import 'package:dyshez/utils/dialogs/show_loading.dart';
import 'package:dyshez/utils/dialogs/show_snackbar.dart';
import 'package:dyshez/view_model/auth_view_model.dart';
import 'package:dyshez/view_model/register_view_model.dart';

Future<void> registerUser(BuildContext context) async {
  final registerViewModel =
      Provider.of<RegisterViewModel>(context, listen: false);
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

  final validationError = registerViewModel.validateFields();
  if (validationError != null) {
    showSnackBar(context, validationError);
    return;
  }

  try {
    showLoadingDialog(context);

    String username = registerViewModel.controllers['Username']!.text;
    String email = registerViewModel.controllers['Email']!.text;
    String phone = registerViewModel.controllers['Teléfono']!.text;
    String name = registerViewModel.controllers['Nombre']!.text;
    String password = registerViewModel.controllers['Contraseña']!.text;

    await authViewModel.signUp(
      username,
      email,
      phone,
      name,
      password,
    );

    Navigator.pop(context); // Cerrar el diálogo de carga

    // Navegar a la página de verificación de correo
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerifyEmailPage(email: email)),
    );
  } catch (e) {
    Navigator.pop(context); // Cerrar el diálogo de carga
    String errorMessage = e.toString();
    if (errorMessage.contains('Límite de solicitudes excedido')) {
      showSnackBar(context,
          'Límite de solicitudes excedido. Intenta de nuevo más tarde.');
    } else if (errorMessage
        .contains('El correo electrónico ya está registrado')) {
      showSnackBar(context, 'El correo electrónico ya está registrado.');
    } else {
      ErrorDialog.show(context, e.toString());
    }
  }
}
