import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
              color:primaryClr
        ),
        child:Center(
          child: Text(
          label,
            style: const TextStyle(
              color:Colors.white,
              fontWeight: FontWeight.bold
        ),
        ),
      ),
      ),
    );
  }
}
