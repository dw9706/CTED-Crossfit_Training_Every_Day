import 'package:flutter/material.dart';

class AddProgramDayButton extends StatelessWidget {
  const AddProgramDayButton(
      {super.key, required this.label, required this.onTap});

  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF33a937)),
          child: Center(
              child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        ));
  }
}
