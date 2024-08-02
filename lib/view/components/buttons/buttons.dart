import 'package:flutter/material.dart';

class ButtonsComponents extends StatelessWidget {
  final Color color;
  final String title;
  final void Function()? onPress;
  const ButtonsComponents(
      {required this.color, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'QuickSand-Bold',
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
