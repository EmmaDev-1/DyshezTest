import 'package:dyshez/Utils/dialogs/login_dialog.dart';
import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/components/Logo/logo_image.dart';
import 'package:dyshez/view/components/buttons/buttons.dart';
import 'package:dyshez/view/components/text_field/text_field.dart';
import 'package:dyshez/view/pages/authentication_section/register/register.dart';
import 'package:dyshez/view/pages/authentication_section/reset_password/reset_password.dart';
import 'package:dyshez/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  void dispose() {
    Provider.of<LoginViewModel>(context, listen: false).disposeControllers();
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
              loginForm(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              loginMedia(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Center(
      child: Column(
        children: [
          Text(
            'Iniciar Sesión',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'QuickSand-Bold',
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          TextFieldComponent(
            controller: loginViewModel.controllers['Username']!,
            hintText: 'Username',
            prefixIcon: Icons.alternate_email_rounded,
            fieldType: TextInputType.name,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          TextFieldComponent(
            controller: loginViewModel.controllers['Password']!,
            hintText: 'Contraseña',
            fieldType: TextInputType.text,
            obscureText: _obscureText,
            onChanged: (text) {
              setState(() {
                _obscureText = text.isEmpty ? true : _obscureText;
              });
            },
            prefixIcon: Icons.lock_outlined,
            suffixIcon: loginViewModel.controllers['Password']!.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey[800],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          ButtonsComponents(
            color: const Color(0xFFE3026F),
            title: 'Iniciar Sesión',
            onPress: () async {
              await loginUser(context);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            height: MediaQuery.of(context).size.height * 0.045,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  crearRuta(context, const RegisterPage()),
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
                    const TextSpan(text: '¿No tienes cuenta? '),
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
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 0.7,
            color: Color.fromARGB(158, 184, 184, 184),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.045,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  crearRuta(context, const ResetPasswordPage()),
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
                    const TextSpan(text: '¿Olvidaste tu contraseña? '),
                    TextSpan(
                      text: 'Recupera tu cuenta',
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

  loginMedia() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await loginWithGoogle(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 39, 39, 39).withOpacity(0.20),
                    spreadRadius: 0.9,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/googleLogo.png',
                      scale: 12,
                    ),
                  ),
                  Text(
                    '  Iniciar sesión con Google',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'QuickSand-Bold',
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          GestureDetector(
            onTap: () async {},
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 39, 39, 39).withOpacity(0.20),
                    spreadRadius: 0.9,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/appleLogo.png',
                      scale: 12,
                    ),
                  ),
                  Text(
                    ' Iniciar sesión con Apple ID',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'QuickSand-Bold',
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          GestureDetector(
            onTap: () async {},
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 39, 39, 39).withOpacity(0.20),
                    spreadRadius: 0.9,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/facebookLogo.png',
                      scale: 12,
                    ),
                  ),
                  Text(
                    'Iniciar sesión con Facebook',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'QuickSand-Bold',
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
