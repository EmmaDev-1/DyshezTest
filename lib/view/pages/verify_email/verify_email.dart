import 'package:dyshez/Utils/Navigation/navigationAnimationLeftRight.dart';
import 'package:dyshez/view/components/Logo/logo_image.dart';
import 'package:dyshez/view/components/buttons/buttons.dart';
import 'package:dyshez/view/components/text_field/text_field.dart';
import 'package:dyshez/view/pages/login/login.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  //Controllers
  final TextEditingController verifyEmailController = TextEditingController();

  @override
  void dispose() {
    verifyEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            const LogoImageComponent(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            verifyForm()
          ],
        ),
      )),
    );
  }

  verifyForm() {
    return Center(
      child: Column(
        children: [
          Text(
            'Verificar email',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'QuickSand-Bold',
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(
            'Enviaremos un código a tu email.',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontWeight: FontWeight.w500,
                fontFamily: 'QuickSand',
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          TextFieldComponent(
            controller: verifyEmailController,
            hintText: 'Email',
            prefixIcon: Icons.email_outlined,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          ButtonsComponents(
            color: Colors.black,
            title: 'Confirmar',
            onPress: () {},
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            height: MediaQuery.of(context).size.height * 0.045,
            child: TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  crearRutaIzquierdaADerecha(context, const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.037,
                      fontFamily: 'QuickSand',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  children: [
                    const TextSpan(text: '¿Ya tienes una cuenta? '),
                    TextSpan(
                      text: 'Inicia Sesión',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontFamily: 'QuickSand-Bold',
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFE3026F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
