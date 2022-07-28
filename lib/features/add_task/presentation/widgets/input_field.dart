import 'package:flutter/material.dart';

import '../../../../core/theme.dart';



// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final String title;
  final String hint;
  TextEditingController? controller;
  final Widget? widget;
  InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(title, style: titlestyle)),
          Container(
            padding: const EdgeInsets.only(top: 0, left: 14),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 255, 249),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: const Color.fromARGB(255, 247, 226, 226))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                      cursorColor: Colors.grey,
                      controller: controller,
                      autofocus: false,
                      readOnly: widget != null ? true : false,
                      style: subtitlestyle,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subtitlestyle,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0, color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0, color: Colors.white),
                        ),
                      )),
                ),
                widget ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
