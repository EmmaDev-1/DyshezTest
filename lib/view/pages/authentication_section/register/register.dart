import 'package:dyshez/Utils/dialogs/register_dialog.dart';
import 'package:dyshez/view/components/Logo/logo_image.dart';
import 'package:dyshez/view/components/buttons/buttons.dart';
import 'package:dyshez/view/components/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dyshez/view_model/register_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  bool _obscureTextRepeat = true;

  @override
  void dispose() {
    Provider.of<RegisterViewModel>(context, listen: false).disposeControllers();
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

  Widget registerForm() {
    final registerViewModel = Provider.of<RegisterViewModel>(context);
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
            controller: registerViewModel.controllers['Username']!,
            hintText: 'Username',
            prefixIcon: Icons.alternate_email_rounded,
            fieldType: TextInputType.text,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: registerViewModel.controllers['Nombre']!,
            hintText: 'Nombre',
            prefixIcon: Icons.person_outline_rounded,
            fieldType: TextInputType.text,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: registerViewModel.controllers['Email']!,
            hintText: 'Email',
            prefixIcon: Icons.email_outlined,
            fieldType: TextInputType.emailAddress,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: registerViewModel.controllers['Teléfono']!,
            hintText: 'Teléfono',
            prefixIcon: Icons.phone_outlined,
            fieldType: TextInputType.number,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          TextFieldComponent(
            controller: registerViewModel.controllers['Contraseña']!,
            hintText: 'Contraseña',
            obscureText: _obscureText,
            fieldType: TextInputType.text,
            onChanged: (text) {
              setState(() {
                _obscureText = text.isEmpty ? true : _obscureText;
              });
            },
            prefixIcon: Icons.lock_outlined,
            suffixIcon: registerViewModel
                    .controllers['Contraseña']!.text.isEmpty
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
            controller: registerViewModel.controllers['Verificar contraseña']!,
            hintText: 'Verificar contraseña',
            obscureText: _obscureTextRepeat,
            fieldType: TextInputType.text,
            onChanged: (text) {
              setState(() {
                _obscureTextRepeat = text.isEmpty ? true : _obscureTextRepeat;
              });
            },
            prefixIcon: Icons.lock_outlined,
            suffixIcon: registerViewModel
                    .controllers['Verificar contraseña']!.text.isEmpty
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
            onPress: () => registerUser(context),
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
