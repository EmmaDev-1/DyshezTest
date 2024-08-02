import 'package:flutter/material.dart';

class LogoImageComponent extends StatelessWidget {
  const LogoImageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/images/logo.png'));
  }
}
