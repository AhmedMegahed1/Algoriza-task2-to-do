import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() ontap;
  const MyButton({
    Key? key,
    required this.label,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
