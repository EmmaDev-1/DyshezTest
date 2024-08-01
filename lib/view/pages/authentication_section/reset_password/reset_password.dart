import 'package:dyshez/Utils/dialogs/email_confirmation_dialog.dart';
import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/components/Logo/logo_image.dart';
import 'package:dyshez/view/components/text_field/text_field.dart';
import 'package:dyshez/view/pages/authentication_section/register/register.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
            resetForm()
          ],
        ),
      )),
    );
  }

  resetForm() {
    return Center(
      child: Column(
        children: [
          Text(
            'Recuperar Cuenta',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'QuickSand-Bold',
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          TextFieldComponent(
            controller: verifyEmailController,
            hintText: 'Correo electrónico',
            prefixIcon: Icons.person_outline_rounded,
            fieldType: TextInputType.emailAddress,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.85,
            child: ElevatedButton(
              onPressed: () {
                String email = verifyEmailController.text;
                confirmEmailForResetPassword(context, email);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Restablecer  ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'QuickSand-Bold',
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            height: MediaQuery.of(context).size.height * 0.045,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  crearRuta(const RegisterPage()),
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
                    const TextSpan(text: '¿No tuenes cuenta? '),
                    TextSpan(
                      text: 'Crea una nueva cuenta',
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
