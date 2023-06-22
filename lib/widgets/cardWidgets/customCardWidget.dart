import 'package:flutter/material.dart';
import 'package:win_kamu/utils/utils.dart';

class CustomBox extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? boxColor;
  final bool? isIcon;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final double? descriptionPadding;
  final String? title, description;
  final double? descriptionFontSize;
  const CustomBox(
      {super.key,
      this.height = 93,
      this.width = 93,
      this.boxColor = Colors.green,
      this.isIcon = false,
      this.icon,
      this.iconSize = 10,
      this.title = "Title",
      this.description = "Desc",
      this.iconColor = Colors.white,
      this.titleColor = Colors.white,
      this.descriptionColor = Colors.white,
      this.descriptionPadding = 10,
      this.descriptionFontSize = 14});

  @override
  State<CustomBox> createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.boxColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isIcon!
              ? Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: widget.iconColor,
                )
              : Text(
                  widget.title!,
                  style: TextStyle(fontSize: height_24, color: widget.descriptionColor),
                ),
          SizedBox(
            height: widget.isIcon! ? 0 : 3,
          ),
          Padding(
            padding: EdgeInsets.all(widget.descriptionPadding!),
            child: Text(widget.description!,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: widget.descriptionColor, fontSize: widget.descriptionFontSize!)),
          )
        ],
      ),
    );
  }
}
