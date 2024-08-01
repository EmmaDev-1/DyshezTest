import 'package:dyshez/Utils/dialogs/new_password_dialog.dart';
import 'package:dyshez/Utils/navigation/navegationAnimationRightLeft.dart';
import 'package:dyshez/view/components/Logo/logo_image.dart';
import 'package:dyshez/view/components/buttons/buttons.dart';
import 'package:dyshez/view/components/text_field/text_field.dart';
import 'package:dyshez/view/pages/authentication_section/register/register.dart';
import 'package:flutter/material.dart';

class VerifyNewPassPage extends StatefulWidget {
  const VerifyNewPassPage({super.key});

  @override
  State<VerifyNewPassPage> createState() => _VerifyNewPassPageState();
}

class _VerifyNewPassPageState extends State<VerifyNewPassPage> {
  //variables
  bool _obscureText = true;
  bool _obscureTextRepeat = true;

  //Controllers
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordControllerRepeat =
      TextEditingController();

  @override
  void dispose() {
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
            'Cambiar Contraseña',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'QuickSand-Bold',
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          TextFieldComponent(
            controller: passwordController,
            hintText: 'Nueva Contraseña',
            obscureText: _obscureText,
            fieldType: TextInputType.text,
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
            hintText: 'Verificar nueva contraseña',
            obscureText: _obscureTextRepeat,
            fieldType: TextInputType.text,
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
            title: 'Cambiar contraseña',
            onPress: () {
              String password = passwordController.text;
              setNewPassword(context, password);
            },
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
