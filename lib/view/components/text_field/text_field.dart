import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Function(String)? onChanged;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  const TextFieldComponent({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 39, 39, 39).withOpacity(0.20),
            spreadRadius: 0.9,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.grey[800],
        ),
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 134, 134, 134),
              width: 1.0,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontFamily: 'QuickSand',
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
          contentPadding: const EdgeInsets.all(16.0),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: 20,
                  color: Colors.grey[800],
                )
              : null,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
