import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Function()? onTap;
  const MyButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: primaryClr),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color backgroundColor;
  double size;
  AppButton({
    Key? key,
    required this.color,
    required this.backgroundColor,
    required this.size,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;

  ColorButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 6, left: 0, right: 1, bottom: 6),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: color,
        ));
  }
}

class UnColorButton extends StatelessWidget {
  final Color color;
  final Color backgroundColor;

  UnColorButton({
    Key? key,
    required this.color,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 6,
          ),
          Padding(
              padding:
                  const EdgeInsets.only(top: 6, left: 1.5, right: 3, bottom: 6),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: color,
              )),
          const Icon(
            Icons.done,
            size: 18,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class SmallAppButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color backgroundColor;
  double size;
  SmallAppButton({
    Key? key,
    required this.color,
    required this.backgroundColor,
    required this.size,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 12),
        ),
      ),
    );
  }
}
