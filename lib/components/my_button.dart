import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final FontWeight weight;

  const MyButton({super.key, required this.text, required this.onTap,required this.weight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.orange,

          borderRadius: BorderRadius.circular(8),
        ), // BoxDecoration
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(child: Text(text)), // Center
      ), // Container
    ); // GestureDetector
  }
}
