import 'package:dyshez/Utils/navigation/navigationAnimationLeftRight.dart';
import 'package:dyshez/view/pages/authentication_section/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dyshez/view_model/auth_view_model.dart';

Future<void> SignOutUser(BuildContext context) async {
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

  try {
    await authViewModel.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      crearRutaIzquierdaADerecha(context, const LoginPage()),
      (Route<dynamic> route) => false,
    );
  } catch (e) {
    print('Entro aqui');
    Navigator.pushAndRemoveUntil(
      context,
      crearRutaIzquierdaADerecha(context, const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
}
