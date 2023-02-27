import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTextArea extends StatefulWidget {
  final String hintText;
  final double? padding;
  const CustomTextArea(
      {super.key, this.hintText = "Buraya yazın", this.padding = 20});

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding!),
      child: CupertinoTextField(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Color.fromARGB(255, 235, 235, 235)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        placeholder: widget.hintText,
        placeholderStyle: TextStyle(color: Colors.grey),
        minLines: 4,
        maxLines: 6,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
