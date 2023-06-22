import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

class CustomTextArea extends StatefulWidget {
  final String hintText;
  final double? padding;
  const CustomTextArea({super.key, this.hintText = "Açıklama", this.padding = 20});

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(
        color: APPColors.NewNotifi.grey,
        border: Border.all(color: const Color.fromARGB(255, 235, 235, 235)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      placeholder: widget.hintText,
      placeholderStyle: const TextStyle(
        color: Colors.black,
      ),
      minLines: 3,
      maxLines: 6,
      style: const TextStyle(color: Colors.black),
    );
  }
}
