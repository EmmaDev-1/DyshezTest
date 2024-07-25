import 'package:dyshez/Utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/components/Logo/logo_image.dart';
import 'package:dyshez/view/components/buttons/buttons.dart';
import 'package:dyshez/view/components/text_field/text_field.dart';
import 'package:dyshez/view/pages/verify_email/verify_email.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //variables
  bool _obscureText = true;
  bool _obscureTextRepeat = true;

  //Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordControllerRepeat =
      TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordControllerRepeat.dispose();
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
              registerForm()
            ],
          ),
        ),
      ),
    );
  }

  registerForm() {
    return Center(
      child: Column(
        children: [
          Text(
            'Crear Cuenta',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'QuickSand-Bold',
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: userNameController,
            hintText: 'Username',
            prefixIcon: Icons.alternate_email_rounded,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: nameController,
            hintText: 'Nombre',
            prefixIcon: Icons.person_outline_rounded,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: emailController,
            hintText: 'Email',
            prefixIcon: Icons.email_outlined,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: phoneController,
            hintText: 'Teléfono',
            prefixIcon: Icons.phone_outlined,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: passwordController,
            hintText: 'Contraseña',
            obscureText: _obscureText,
            onChanged: (text) {
              setState(() {
                _obscureText = text.isEmpty ? true : _obscureText;
              });
            },
            prefixIcon: Icons.lock_outlined,
            suffixIcon: passwordController.text.isEmpty
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: passwordControllerRepeat,
            hintText: 'Verificar contraseña',
            obscureText: _obscureTextRepeat,
            onChanged: (text) {
              setState(() {
                _obscureTextRepeat = text.isEmpty ? true : _obscureTextRepeat;
              });
            },
            prefixIcon: Icons.lock_outlined,
            suffixIcon: passwordControllerRepeat.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(
                      _obscureTextRepeat
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[800],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextRepeat = !_obscureTextRepeat;
                      });
                    },
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ButtonsComponents(
            color: Colors.black,
            title: 'Crear cuenta',
            onPress: () {
              Navigator.push(
                context,
                crearRuta(
                    context, const VerifyEmailPage()), // Navega al Dashboard
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            height: MediaQuery.of(context).size.height * 0.045,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
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
