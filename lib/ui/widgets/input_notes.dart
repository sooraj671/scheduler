import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';

class NoteField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const NoteField({
    Key? key,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 6),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromRGBO(78, 91, 232, 0.06),
          ),
          child: Container(
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: TextFormField(
                          readOnly: widget == null ? false : true,
                          autofocus: false,
                          cursorColor: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[700],
                          controller: controller,
                          style: titleStyle,
                          decoration: InputDecoration(
                            hintText: hint,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: context.theme.bottomAppBarColor,
                                    width: 0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: context.theme.bottomAppBarColor,
                                    width: 0)),
                          ))),
                  widget == null ? Container() : Container(child: widget)
                ],
              )),
        ));
  }
}
